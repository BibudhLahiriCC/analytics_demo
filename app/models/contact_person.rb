class ContactPerson < ActiveRecord::Base

  belongs_to :contact, inverse_of: :contact_people
  belongs_to :person

  validates :contact, presence: true
  validates :person, presence: true

end


