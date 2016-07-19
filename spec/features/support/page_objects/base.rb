module PageObjects
  class Base
    include Capybara::DSL

    def initialize(page = nil)
      @page = page
    end

    def self.on_page!
      obj = new
      obj.find_on_page!
    end

    def self.from_string!(string)
      obj = new(Capybara.string(string))
      obj.find_on_page!
    end

    def page
      @page || super
    end

    def on_page?
      begin
        main_element
      rescue Capybara::ElementNotFound
        return false
      end
      return true
    end

    def find_on_page!
      unless on_page?
        raise "#{name} couldn't be instantiated because the main element "\
              "couldn't be found on the page."
      end
      self
    end
  end
end
