class Mongo::Verification
    include Mongoid::Document
    store_in collection: 'verifications'
    mount_uploaders :files, MongoDocumentUploader
    # mount_uploaders :selectFiles, MongoDocumentUploader

    field :lastUpdate, type: DateTime
    field :created, type: DateTime
    field :emails, type: Array
    field :ofMixed, type: Array
    field :denied, type: String
    field :emailClass, type: String
    field :admin, type: String
    field :confirmed, type: String
    field :passportData, type: String
    field :status, type: String
    field :lostAcc, type: String
    field :name, type: String
    field :lastName, type: String
    field :passportClass, type: String
    field :nameClass, type: String
    field :selectFiles, type: Array
    field :cause, type: String
    field :files, type: Array
    field :comment, type: String
    field :ban, type: Boolean
    field '__v', type: Integer

    def postgres_export
        pg_verifcation = ::Verification.find_or_create_by legacy_verification_id: self['_id']
        pg_verifcation.documents = []
        grid_fs = Mongoid::GridFs

        self['files'].each do |file_object|
            filename = [File.basename(file_object['filename']), File.extname(file_object['filename'])]
            tempfile = Tempfile.new filename, binary: true

            fs = grid_fs.get(file_object['file'])
            fs.each { |chunk| tempfile.write chunk.force_encoding(Encoding::UTF_8) }

            uploader = DocumentUploader.new pg_verifcation,'documents'
            uploader.store! tempfile
            pg_verifcation.documents << uploader

            tempfile.close
            tempfile.unlink
        end

        pg_verifcation.save
    end
end