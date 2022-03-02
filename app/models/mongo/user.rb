class Mongo::User
    include Mongoid::Document
    store_in collection: 'users'

end