class Contact < ActiveRecord::Base

  MODES = [ CORRESPONDENCE_MODE = "Correspondence",
    EMAIL_MODE = "E-Mail",
    CHILD_HOME_FACE_TO_FACE_MODE = "Face to Face - Child's Home",
    OTHER_HOME_FACE_TO_FACE_MODE = "Face to Face - Other Home",
    OFFICE_FACE_TO_FACE_MODE = "Face to Face - Office",
    OTHER_FACE_TO_FACE_MODE = "Face to Face - Other",
    FAX_MODE = "Fax",
    TELEPHONE_MODE = "Telephone",
    VOICEMAIL_MODE = "Voicemail" ]
  FACE_TO_FACE_MODES = [CHILD_HOME_FACE_TO_FACE_MODE, OTHER_HOME_FACE_TO_FACE_MODE, OFFICE_FACE_TO_FACE_MODE, OTHER_FACE_TO_FACE_MODE]

  attr_accessible :legacy_id, :note_id, :note_legacy_id, :contact_people_attributes,
    :mode, :occurred_at, :other_reason_for_contact, :successful, :created_at, :updated_at, *TYPES

  has_many :contact_people, inverse_of: :contact
  accepts_nested_attributes_for :contact_people

  validates :mode, presence: true, inclusion: MODES

end

