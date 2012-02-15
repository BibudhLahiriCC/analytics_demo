class PhysicalLocationRecord < ActiveRecord::Base
  belongs_to :physical_location,
             :inverse_of => :physical_location_record,
             :class_name => "OutOfHomeLocation"

  delegate :type, :resource_name, :address, :end_date,
           :start_date, :ends_episode?,
           :to => :physical_location, :allow_nil => true
  #Using the delegation design pattern here. The methods to get
  #start_date etc are actually provided by the PhysicalLocation
  #class.

end

