# encoding: UTF-8

# Install webpacker
current_dir = File.dirname(__FILE__)

copy_file "#{current_dir}/config/webpacker.yml", "config/webpacker.yml"

puts "Copying webpack core config and loaders"
directory "#{current_dir}/config/webpack", "config/webpack"
directory "#{current_dir}/config/loaders/core", "config/webpack/loaders"

puts "Copying .postcssrc.yml to app root directory"
copy_file "#{current_dir}/config/.postcssrc.yml", ".postcssrc.yml"

puts "Copying .babelrc to app root directory"
copy_file "#{current_dir}/config/.babelrc", ".babelrc"

puts "Creating javascript app source directory"
directory "#{current_dir}/javascript", "#{Webpacker::Configuration.source}"

puts "Copying binstubs"
directory "#{current_dir}/bin", "bin"

chmod "bin", 0755 & ~File.umask, verbose: false

if File.exists?(".gitignore")
  append_to_file ".gitignore", <<-EOS
/public/packs
/node_modules
EOS
end

puts "Installing all JavaScript dependencies"
run "yarn add webpack webpack-merge js-yaml path-complete-extname " \
"webpack-manifest-plugin babel-loader@7.x coffee-loader coffee-script " \
"babel-core babel-preset-env babel-polyfill compression-webpack-plugin rails-erb-loader glob " \
"extract-text-webpack-plugin node-sass file-loader sass-loader css-loader style-loader " \
"postcss-loader postcss-cssnext postcss-smart-import resolve-url-loader " \
"babel-plugin-syntax-dynamic-import babel-plugin-transform-class-properties"

puts "Installing dev server for live reloading"
run "yarn add --dev webpack-dev-server"

puts "Webpacker successfully installed 🎉 🍰"
