class Mongo::User
    include Mongoid::Document
    store_in collection: 'users'

    field :ofMixed, type: Array
    field :ban, type: Boolean
    field :selectFiles, type: Array
    field :nameClass, type: String
    field :cause, type: String
    field :lastUpdate, type: DateTime
    field :created, type: DateTime
    field :passportData, type: String
    field :lastName, type: String
    field :name, type: String
    field :emails, type: Array
    field :denied, type: Boolean
    field :files, type: Array
    field :lostAcc, type: String
    field '__v', type: String
    field :comment, type: String
end