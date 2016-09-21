unless Rails.application.config.cache_classes &&
       Rails.application.config.eager_load
  ActiveSupport::Reloader.to_prepare do
    Dir["#{Rails.root}/app/models/*_story.rb"].each do |file|
      require_dependency file
    end
  end
end
