

Buildings = new Mongo.Collection 'buildings'

Buildings.allow {
    insert: (username, doc) -> username?
}

root = exports ? @
root.Buildings = Buildings