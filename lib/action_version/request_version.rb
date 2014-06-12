module ActionVersion

  def self.request_version(env)
    # Accept: application/json; version=12345
    # Accept: application/vnd.api+json; version=12345
    if /version=(?<version>\d+)/ =~ env['HTTP_ACCEPT']
      version.to_i
    end
  end

  module RequestVersion
    extend ActiveSupport::Concern

    protected
      def require_version!
        raise InvalidVersionError, "Version not provided" unless request_version
      end

      def request_version
        @request_version ||= ActionVersion.request_version(env)
      end

    module ClassMethods
      def default_version
        Time.now.strftime("%Y%m%d").to_i
      end
    end
  end
end
