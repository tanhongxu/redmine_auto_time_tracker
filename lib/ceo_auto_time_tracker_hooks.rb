module CEOAutoTimeTrackerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :update, :time_track
    end
  end
  
  module InstanceMethods
    def update_with_time_track
      update_without_time_track
      Rails.logger.info '0000000000000000'
    end
  end
end