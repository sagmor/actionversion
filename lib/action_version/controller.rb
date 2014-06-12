module ActionVersion
  module Controller
    extend ActiveSupport::Concern
    include ActionVersion::Versionable
    include ActionVersion::RequestVersion

    class CallProxy
      def initialize(klass,action)
        @klass = klass
        @action = action
      end

      def call(env)
        version = ActionVersion.request_version(env)
        version ||= @klass.default_version

        @klass.version(version).action(@action).call(env)
      end
    end

    module ClassMethods
      def action(name)
        if self.versioned?
          CallProxy.new(self,name)
        else
          super
        end
      end

      private
        def build_version(version_id,options,&block)
          super(version_id,options) do
            define_method(:perform, &block)
          end
        end
    end
  end
end


