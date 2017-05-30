# encoding: UTF-8

require "webpacker/configuration"


current_dir = File.dirname(__FILE__)

babelrc = Rails.root.join(".babelrc")

if File.exist?(babelrc)
  react_babelrc = JSON.parse(File.read(babelrc))
  react_babelrc["presets"] ||= []

  unless react_babelrc["presets"].include?("react")
    react_babelrc["presets"].push("react")
    puts "Copying react preset to your .babelrc file"

    File.open(babelrc, "w") do |f|
      f.puts JSON.pretty_generate(react_babelrc)
    end
  end
else
  puts "Copying .babelrc to app root directory"
  copy_file "#{current_dir}/examples/react/.babelrc", ".babelrc"
end

puts "Copying react loader to config/webpack/loaders"
copy_file "#{current_dir}/config/loaders/installers/react.js", "config/webpack/loaders/react.js"

puts "Copying react example entry file to #{Webpacker::Configuration.entry_path}"
copy_file "#{current_dir}/examples/react/hello_react.jsx", "#{Webpacker::Configuration.entry_path}/hello_react.jsx"

puts "Installing all react dependencies"
run "yarn add react react-dom babel-preset-react prop-types"

puts "Webpacker now supports react.js 🎉"
