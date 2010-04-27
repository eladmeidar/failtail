task :compile do
  rails_root = File.expand_path("../../..", __FILE__)
  sh "sass #{rails_root}/app/styles/sass/application.sass > #{rails_root}/public/stylesheets/application.css" 
end