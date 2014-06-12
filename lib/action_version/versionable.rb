module ActionVersion
  class VersionError < RuntimeError; end
  class VersionNotFoundError < VersionError; end
  class InvalidVersionError < VersionError; end

  module Versionable
    extend ActiveSupport::Concern

    module ClassMethods
      def version(version_id,options={},&block)
        version_id = Integer(version_id)
        raise ArgumentError if version_id <= 0

        # If a block is provided we are defininfg a new version.
        if block
          build_version(version_id,options,&block)
        else
          get_version(version_id)
        end

      rescue ArgumentError
        raise InvalidVersionError, "#{version_id} is not a valid version number"
      end

      def versions_ids
        versions.keys.sort
      end

      def last_version_id
        versions_ids.last
      end

      def versioned?
        !versions.empty?
      end

      private
        def versions
          @versions ||= {}
        end

        def get_version(version_id)
          versions.fetch( versions_ids.reverse.find{ |id| id <= version_id } ) do
            raise ActionVersion::VersionNotFoundError, "Version #{version_id} not found in #{self.inspect}"
          end
        end

        def build_version(version_id,options,&block)
          klass = Class.new(options.fetch(:parent){ self })

          Array(options[:includes]).each do |include|
            klass.send :include, include
          end

          klass.send :class_eval, &block

          versions[version_id] = klass
          self.const_set("V#{version_id}", klass)

          klass
        end
    end
  end
end
