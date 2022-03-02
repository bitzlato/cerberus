class Verification < ApplicationRecord
  belongs_to :applicant, required: false
  mount_uploaders :documents, DocumentUploader


end
