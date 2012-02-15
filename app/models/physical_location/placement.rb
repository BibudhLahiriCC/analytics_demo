class PhysicalLocation::Placement < OutOfHomeLocation
  accepts_nested_attributes_for :physical_location_record

  #FIXME: Remove post API freeze
  alias_attribute :placement_change, :reason_for_change
  #reason_for_change is a column in out_of_home_locations.
  #placement_change is an alias for :reason_for_change.

end

