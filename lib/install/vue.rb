# encoding: UTF-8

require "webpacker/configuration"

current_dir = File.dirname(__FILE__)

puts "Copying vue loader to config/webpack/loaders"
copy_file "#{current_dir}/config/loaders/installers/vue.js", "config/webpack/loaders/vue.js"

puts "Copying the example entry file to #{Webpacker::Configuration.entry_path}"
copy_file "#{current_dir}/examples/vue/hello_vue.js", "#{Webpacker::Configuration.entry_path}/hello_vue.js"

puts "Copying vue app file to #{Webpacker::Configuration.entry_path}"
copy_file "#{current_dir}/examples/vue/app.vue", "#{Webpacker::Configuration.entry_path}/app.vue"

puts "Installing all vue dependencies"
run "yarn add vue vue-loader vue-template-compiler"

puts "Webpacker now supports vue.js 🎉"
