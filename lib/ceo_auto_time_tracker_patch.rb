# status id:
#	1 -- new;
#	2 -- in progress;
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
      
      if params[:status_id] == '2' # status_id is new status, changed from 'any' -> 'in process'
      	Rails.logger.info '111111111111111'
      	
        # get time tracker and start it
        @time_tracker = TimeTracker.new(:issue_id => params[:id], :activity_id => 9, :project_id => params[:project_id])
        
        #todo: show error msg if already started
	    @time_tracker.start
	    
	  else
	  	
	  	@time_tracker = TimeTracker.where(:issue_id => params[:id]).first;
	  	
	  	@time_tracker.stop if @time_tracker != nil
      end
    end
  end
end