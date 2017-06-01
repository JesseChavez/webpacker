WEBPACKER_APP_TEMPLATE_PATH = File.expand_path("../../install/template.rb", File.dirname(__FILE__))

if Webpacker.rails_less_than_42?
  namespace :rails do
    desc 'Redefined by Webpacker'
    task template: :environment do
      puts 'Adding environment for legacy apps'
    end
  end
end

namespace :webpacker do
  desc "Install webpacker in this application"
  task install: [:check_node, :check_yarn] do
    if Rails::VERSION::MAJOR >= 5
      exec "#{RbConfig.ruby} ./bin/rails app:template LOCATION=#{WEBPACKER_APP_TEMPLATE_PATH}"
    elsif Rails::VERSION::MAJOR >= 4
      exec "#{RbConfig.ruby} ./bin/rake rails:template LOCATION=#{WEBPACKER_APP_TEMPLATE_PATH}"
    else
      exec "rake rails:template LOCATION=#{WEBPACKER_APP_TEMPLATE_PATH}"
    end
  end
end
