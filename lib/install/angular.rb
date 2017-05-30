# encoding: UTF-8

require "webpacker/configuration"

current_dir = File.dirname(__FILE__)

puts "Copying angular loader to config/webpack/loaders"
copy_file "#{current_dir}/config/loaders/installers/angular.js", "config/webpack/loaders/angular.js"

puts "Copying angular example entry file to #{Webpacker::Configuration.entry_path}"
copy_file "#{current_dir}/examples/angular/hello_angular.js", "#{Webpacker::Configuration.entry_path}/hello_angular.js"

puts "Copying hello_angular app to #{Webpacker::Configuration.source_path}"
directory "#{current_dir}/examples/angular/hello_angular", "#{Webpacker::Configuration.source_path}/hello_angular"

puts "Copying tsconfig.json to the Rails root directory for typescript"
copy_file "#{current_dir}/examples/angular/tsconfig.json", "tsconfig.json"

puts "Installing all angular dependencies"
run "yarn add typescript ts-loader core-js zone.js rxjs @angular/core @angular/common @angular/compiler @angular/platform-browser @angular/platform-browser-dynamic"

puts "Webpacker now supports angular and typescript 🎉"
