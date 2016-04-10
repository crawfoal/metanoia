require 'rails_helper'

RSpec.describe ExtractValue do
  class Comment
    include ExtractValue
    extract_value_from :body, :author_name

    # pretend 'body' and 'author_name' are columns for this model
    attr_accessor :body, :author_name
    def initialize(options = {})
      @body = options[:body]
      @author_name = options[:author_name]
    end
  end

  class Post
    include ExtractValue
    extract_value_from :body, collections: :comments

    # pretend 'body' is a column for this model, and 'comments' is a has_many association
    attr_accessor :body, :comments
    attr_accessor :comments
    def initialize(options = {})
      @body = options[:body]
      @comments = Array(options[:comments])
    end
  end

  describe '.extract_value_from' do
    it 'builds `.attributes_to_extract`, which returns the names of the attributes that should be extracted when getting the "value" of the record' do
      expect(Comment.attributes_to_extract).to eq [:body, :author_name]
    end

    it 'builds `.collections_to_extract`, which returns the names of the collections that should be extracted when getting the "value" of the record' do
      expect(Post.collections_to_extract).to eq [:comments]
    end

    it 'appends new entries when called multiple times (does not overwrite previous values)' do
      class Klass
        include ExtractValue
        extract_value_from :attrib_1, collections: :collection_1
        extract_value_from :attrib_2, collections: :collection_2
      end

      expect(Klass.attributes_to_extract).to eq [:attrib_1, :attrib_2]
      expect(Klass.collections_to_extract).to eq [:collection_1, :collection_2]
    end
  end

  describe '#value' do
    it 'builds a hash of the values for the attributes specified via "extract_value_from"' do
      value = {
        body: 'I finally understand method resolution in Ruby!',
        author_name: 'Amanda Dolan'
      }
      expect(Comment.new(value).value).to eq value
    end

    it 'includes an array of the #value results for each item in the collection (when the collection option was used in `.extract_value_from`)' do
      post = Post.new(body: 'Post body')
      Array(1..3).each { |index| post.comments << Comment.new(body: "Comment body #{index}", author_name: "Author name #{index}") }

      expect(post.value).to eq({
        body: 'Post body',
        comments: [
          {body: 'Comment body 1', author_name: 'Author name 1'},
          {body: 'Comment body 2', author_name: 'Author name 2'},
          {body: 'Comment body 3', author_name: 'Author name 3'}
        ]
      })
    end

    it "returns nil if the are no value attributes or collections defined" do
      class Qlass
        include ExtractValue
      end
      expect(Qlass.new.value).to be_nil
    end

    it "doesn't include collection keys pointing to nil values when the collection is empty" do
      post = Post.new(body: 'Post body')
      expect(post.value).to eq({body: 'Post body'})
    end

    it "doesn't include blank values (e.g. empty strings, nil) when you specify the `reject_blanks: true` option" do
      blank_comment = Comment.new(body: '')
      expect(blank_comment.value(reject_blanks: true)).to be_nil

      post = Post.new(comments: Array(1..2).map{ Comment.new } << blank_comment)
      expect(post.value(reject_blanks: true)).to be_nil
    end
  end
end
