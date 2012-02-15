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

  @current_date = Time.now.strftime("%Y-%m-%d")

  scope :in_placement,
    where('type = ? and date(start_date) <= ? and (date(end_date) is NULL or date(out_of_home_locations.end_date) > ?)',
          'PhysicalLocation::Placement',
           '#{current_date}', '#{current_date}')
  #scope :in_placement_and_had_contact,
  #      :in_placement.and()


  def last_face_to_face_visit_date
  #  Person.where()
  #  Person.all.select{|person| person.placements.any? }
  #  contact_person.contacts.where(end_date: null)
  #  placements
  puts(@current_date)
  puts(#{self.id})
  Person.find_by_sql ["select max(date(contacts.occurred_at)) lastVisitDate from people
     inner join physical_location_records on physical_location_records.person_id = people.id
                and physical_location_records.physical_location_type = ?
                inner join out_of_home_locations on out_of_home_locations.id = physical_location_records.physical_location_id
                and date(out_of_home_locations.start_date) <= ?
                and (date(out_of_home_locations.end_date) is NULL
                or date(out_of_home_locations.end_date) > ?)
     inner join contact_people on contact_people.person_id = people.id
     inner join contacts on contacts.id = contact_people.contact_id
                and contacts.mode like 'Face to Face%'
                where people.id = ?",
                'PhysicalLocation::Placement',
                '2012-02-14', '2012-02-14', #{self.id}]
  end
end
