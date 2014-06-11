module ActionVersion
  class Middleware
    KEY = "action_version.request_version"

    def initialize(app, options= {})
      @app = app
      @options = options
    end

    def extract_version(env)
      if /version=(?<version>\d+)$/ =~ env['HTTP_ACCEPT']
        version.to_i
      end
    end

    def default_version(env)
      default = @options[:default]
      return nil unless default

      if default.respond_to?(:call)
        # Call the proc
        default = default.call(env)
      elsif default == Time
        # Date in format YYYYMMDD
        default = Time.now.strftime("%Y%m%d")
      end

      Integer(default)
    end

    def call(env)
      request_version = extract_version(env)
      request_version ||= default_version(env)

      if request_version.nil? && @options[:required]
        # TODO: show error
        raise "Version Required"
      end

      env[KEY] = request_version

      @app.call(env)
    end

  end
end
