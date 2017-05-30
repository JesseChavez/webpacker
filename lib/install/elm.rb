# encoding: UTF-8

require "webpacker/configuration"

current_dir = File.dirname(__FILE__)

puts "Copying elm loader to config/webpack/loaders"
copy_file "#{current_dir}/config/loaders/installers/elm.js",
          "config/webpack/loaders/elm.js"

puts "Copying elm example entry file to #{Webpacker::Configuration.entry_path}"
copy_file "#{current_dir}/examples/elm/Main.elm", "#{Webpacker::Configuration.entry_path}/Main.elm"

puts "Copying elm app file to #{Webpacker::Configuration.entry_path}"
copy_file "#{current_dir}/examples/elm/hello_elm.js",
          "#{Webpacker::Configuration.entry_path}/hello_elm.js"

puts "Installing all elm dependencies"
run "yarn add elm elm-webpack-loader"
run "yarn add --dev elm-hot-loader"
run "yarn run elm package install -- --yes"

puts "Updating Webpack paths to include Elm file extension"
insert_into_file Webpacker::Configuration.file_path, "    - .elm\n", after: /extensions:\n/

puts "Updating elm source location"
source_path = File.join(Webpacker::Configuration.source, Webpacker::Configuration.fetch(:source_entry_path))
gsub_file "elm-package.json", /\"\.\"\n/, %("#{source_path}"\n)

puts "Updating .gitignore to include elm-stuff folder"
insert_into_file ".gitignore", "/elm-stuff\n", before: "/node_modules\n"

puts "Webpacker now supports elm 🎉"
