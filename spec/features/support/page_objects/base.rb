module PageObjects
  class Base
    include Capybara::DSL

    def self.on_page!
      obj = new
      unless obj.on_page?
        raise "#{name} couldn't be instantiated because the main element "\
              "couldn't be found on the page."
      end
      return obj # test should interract with page object, not actual form element
    end

    def on_page?
      begin
        main_element
      rescue Capybara::ElementNotFound
        return false
      end
      return true
    end
  end
end
