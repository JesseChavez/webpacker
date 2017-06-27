module Webpacker::Helper
  # Computes the full path for a given webpacker asset.
  # Return relative path using manifest.json and passes it to asset_url helper
  # This will use asset_path internally, so most of their behaviors will be the same.
  # Examples:
  #
  # In development mode:
  #   <%= asset_pack_path 'calendar.js' %> # => "/packs/calendar.js"
  # In production mode:
  #   <%= asset_pack_path 'calendar.css' %> # => "/packs/calendar-1016838bab065ae1e122.css"
  def asset_pack_path(name, *options)
    asset_path(Webpacker::Manifest.lookup(name), *options)
  end
  # Creates a script tag that references the named pack file, as compiled by Webpack per the entries list
  # in config/webpack/shared.js. By default, this list is auto-generated to match everything in
  # app/javascript/packs/*.js. In production mode, the digested reference is automatically looked up.
  #
  # Examples:
  #
  #   # In development mode:
  #   <%= javascript_pack_tag 'calendar', 'data-turbolinks-track': 'reload' %> # =>
  #   <script src="/packs/calendar.js" data-turbolinks-track="reload"></script>
  #
  #   # In production mode:
  #   <%= javascript_pack_tag 'calendar', 'data-turbolinks-track': 'reload' %> # =>
  #   <script src="/packs/calendar-1016838bab065ae1e314.js" data-turbolinks-track="reload"></script>
  def javascript_pack_tag(name, *options)
    javascript_include_tag(Webpacker::Manifest.lookup("#{name}#{compute_asset_extname(name, type: :javascript)}"), *options)
  end

  # Creates a link tag that references the named pack file, as compiled by Webpack per the entries list
  # in config/webpack/shared.js. By default, this list is auto-generated to match everything in
  # app/javascript/packs/*.js. In production mode, the digested reference is automatically looked up.
  #
  # Examples:
  #
  #   # In development mode:
  #   <%= stylesheet_pack_tag 'calendar', 'data-turbolinks-track': 'reload' %> # =>
  #   <link rel="stylesheet" media="screen" href="/packs/calendar.css" data-turbolinks-track="reload" />
  #
  #   # In production mode:
  #   <%= stylesheet_pack_tag 'calendar', 'data-turbolinks-track': 'reload' %> # =>
  #   <link rel="stylesheet" media="screen" href="/packs/calendar-1016838bab065ae1e122.css" data-turbolinks-track="reload" />
  def stylesheet_pack_tag(name, *options)
    stylesheet_link_tag(Webpacker::Manifest.lookup("#{name}#{compute_asset_extname(name, type: :stylesheet)}"), *options)
  end

  def compute_asset_extname(source, options = {})
    return if options[:extname] == false
    extname = options[:extname] || ASSET_EXTENSIONS[options[:type]]
    if extname && File.extname(source) != extname
      extname
    else
      nil
    end
  end

  def compute_asset_host(source = "", options = {})
    request = self.request if respond_to?(:request)
    host = options[:host]
    host ||= config.asset_host if defined? config.asset_host

    if host
      if host.respond_to?(:call)
        arity = host.respond_to?(:arity) ? host.arity : host.method(:call).arity
        args = [source]
        args << request if request && (arity > 1 || arity < 0)
        host = host.call(*args)
      elsif host.include?("%d")
        host = host % (Zlib.crc32(source) % 4)
      end
    end

    host ||= request.base_url if request && options[:protocol] == :request
    return unless host

    if URI_REGEXP.match?(host)
      host
    else
      protocol = options[:protocol] || config.default_asset_host_protocol || (request ? :request : :relative)
      case protocol
      when :relative
        "//#{host}"
      when :request
        "#{request.protocol}#{host}"
      else
        "#{protocol}://#{host}"
      end
    end
  end

  ASSET_EXTENSIONS = {
        javascript: ".js",
        stylesheet: ".css"
  }
end
