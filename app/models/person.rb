module CurrentLocationExtension
  def current
    if loaded?
      target.select { |location| location.end_date.nil? }
    else
      where("#{table_name}.end_date IS NULL")
    end
  end

end

class Person < ActiveRecord::Base
attr_accessor :created_by_dialog, :generation, :relationship_name, :score

  has_many :physical_location_records, :inverse_of => :person
  has_many :placements, :through => :physical_location_records,
           :source => :physical_location,  #name of source association
           :class_name => "PhysicalLocation::Placement",
           :extend => CurrentLocationExtension #ensures that placement is current one


  def days_since_last_f2f_visit

   current_date = Time.now.strftime("%Y-%m-%d")
   puts("#{current_date}")
   last_visit_date_sql = <<-SQL
     select '#{current_date}' - max(date(contacts.occurred_at)) lastVisitDate from people
     inner join physical_location_records on physical_location_records.person_id = people.id
                and physical_location_records.physical_location_type = 'PhysicalLocation::Placement'
                inner join out_of_home_locations on out_of_home_locations.id = physical_location_records.physical_location_id
                and date(out_of_home_locations.start_date) <= '#{current_date}'
                and (date(out_of_home_locations.end_date) is NULL
                or date(out_of_home_locations.end_date) > '#{current_date}')
     inner join contact_people on contact_people.person_id = people.id
     inner join contacts on contacts.id = contact_people.contact_id
                and contacts.mode like 'Face to Face%'
                where people.id = #{self.id}
   SQL

   last_visit_date = ActiveRecord::Base.connection.select_value(last_visit_date_sql)
  end
end
