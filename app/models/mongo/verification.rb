class Mongo::Verification
    include Mongoid::Document
    store_in collection: 'verifications'

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
    field '__v', type: Integer
    field :comment, type: String
    field :ban, type: Boolean
end