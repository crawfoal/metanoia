if Rails.application.config.cache_classes == false
  ActionDispatch::Reloader.to_prepare do
    Dir["#{Rails.root}/app/models/*_story.rb"].each {|file| require_dependency file}
  end
end
