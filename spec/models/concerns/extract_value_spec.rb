require 'rails_helper'

RSpec.describe ExtractValue do
  m = Module.new

  class m::Comment
    include ExtractValue
    extract_value_from :body, :author_name

    # pretend 'body' and 'author_name' are columns for this model
    attr_accessor :body, :author_name
    def initialize(options = {})
      @body = options[:body]
      @author_name = options[:author_name]
    end
  end

  class m::Post
    include ExtractValue
    extract_value_from :body, collections: :comments

    # pretend 'body' is a column for this model
    # pretend 'comments' is a has_many association
    attr_accessor :body, :comments
    attr_accessor :comments
    def initialize(options = {})
      @body = options[:body]
      @comments = Array(options[:comments])
    end
  end

  describe '.extract_value_from' do
    it 'adds the attribute names to `.attributes_to_extract`' do
      expect(m::Comment.attributes_to_extract).to eq [:body, :author_name]
    end

    it 'adds the collection names to `.collections_to_extract`' do
      expect(m::Post.collections_to_extract).to eq [:comments]
    end

    it 'appends new entries when called multiple times (does not overwrite '\
       'previous values)' do
      class m::Klass
        include ExtractValue
        extract_value_from :attrib_1, collections: :collection_1
        extract_value_from :attrib_2, collections: :collection_2
      end

      expect(m::Klass.attributes_to_extract).to eq [:attrib_1, :attrib_2]
      expect(m::Klass.collections_to_extract).to eq [:collection_1, :collection_2]
    end
  end

  describe '#value' do
    it 'builds a hash of the values for the attributes specified via '\
       '"extract_value_from"' do
      value = {
        body: 'I finally understand method resolution in Ruby!',
        author_name: 'Amanda Dolan'
      }

      expect(m::Comment.new(value).value).to eq value
    end

    it 'includes an array of the #value results for each item in the '\
       'collection' do
      post = m::Post.new(body: 'Post body')
      Array(1..3).each do |index|
        comment = m::Comment.new(
          body: "Comment body #{index}",
          author_name: "Author name #{index}"
        )
        post.comments << comment
      end

      expect(post.value).to eq(
        body: 'Post body',
        comments: [
          { body: 'Comment body 1', author_name: 'Author name 1' },
          { body: 'Comment body 2', author_name: 'Author name 2' },
          { body: 'Comment body 3', author_name: 'Author name 3' }
        ]
      )
    end

    it 'returns nil if the are no value attributes or collections defined' do
      class m::Qlass
        include ExtractValue
      end

      expect(m::Qlass.new.value).to be_nil
    end

    it "doesn't include collection keys pointing to nil values when the "\
       'collection is empty' do
      post = m::Post.new(body: 'Post body')
      
      expect(post.value).to eq(body: 'Post body')
    end

    it "doesn't include blank values (e.g. empty strings, nil) when you "\
       "specify the `reject_blanks: true` option" do
      blank_comment = m::Comment.new(body: '')
      expect(blank_comment.value(reject_blanks: true)).to be_nil

      comments = Array(1..2).map { m::Comment.new } << blank_comment
      post = m::Post.new(comments: comments)
      expect(post.value(reject_blanks: true)).to be_nil
    end
  end
end
