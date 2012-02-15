class OutOfHomeLocation < ActiveRecord::Base

  has_one :physical_location_record,
          :foreign_key => :physical_location_id,
          :inverse_of => :physical_location, :dependent => :destroy
  #Deleting a record in out_of_home_locations deletes the corresponding
  #record in physical_location_record

  private

end

