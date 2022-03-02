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


    def files
        @files ||= begin
            array = []
            grid_fs = Mongoid::GridFs

            self['files'].each do |file_object|
                array << Tempfile.create { |f| f << "abc\n" }
                array << grid_fs.get(file_object['file']) rescue nil
            end
            array
        end
    end
end