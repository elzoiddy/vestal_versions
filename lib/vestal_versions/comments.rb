module VestalVersions
  # Provides a way for comments/reason for update to be associated with specific 
  # versions
  
  module Comments
    def self.included(base) # :nodoc:
      base.class_eval do
        include InstanceMethods
        attr_accessor :reason_for_update
      end
    end

    # Methods added to versioned ActiveRecord::Base instances to enable versioning with 
    # additional column to store a comment or reason for updating

    module InstanceMethods
      private
        # Overrides the +version_attributes+ method to include a comment passed into the
        # parent object, by way of a +reason_for_update+ attr_accessor.
        def version_attributes
          super.merge(:reason_for_update => reason_for_update)
        end
    end
  end
end
