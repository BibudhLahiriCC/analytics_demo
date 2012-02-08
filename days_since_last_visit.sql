DROP VIEW IF EXISTS days_since_last_visit; 

CREATE VIEW days_since_last_visit AS 
   select b.person_id as person_id, people.gender as gender, 
          (current_date - max(date(contacts.occurred_at))) as n_days_since_last_visit
   from physical_location_records, physical_location_placements, 
        contact_people b, contacts, people
   where physical_location_records.person_id = b.person_id
   and physical_location_records.physical_location_id = physical_location_placements.id
   and physical_location_records.physical_location_type = 'PhysicalLocation::Placement'
   and date(physical_location_placements.start_date) <= current_date
   and (date(physical_location_placements.end_date) is NULL or date(physical_location_placements.end_date) > current_date)
   and contacts.mode like 'Face to Face%'
   and contacts.id = b.contact_id
   and b.person_id = people.id
   group by b.person_id, people.gender;
   
