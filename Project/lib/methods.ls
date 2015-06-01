# 操作数据库的方法
Meteor.methods {
  insertBuilding: (id, name) !->
    Meteor.users.update {'_id': id}, {$set: {'profile.building': name}}, {upsert: true}
  
  insertRoom: (id, rname, bname) !->
    new-room =
      name: rname
      building: bname
      notifs: []
    rid = Rooms.insert new-room
    Meteor.users.update {'_id': id}, {$set: {'profile.room': rid}}, {upsert: true}
    Meteor.users.update {'profile.building': bname}, {$push: {'profile.rooms': {name: rname}}}, {upsert: true}
  
  joinRoom: (id, rname, bname) ->
    doc = Rooms.find-one {'name': rname, 'building': bname}
    console.log doc._id
    Meteor.users.update {'_id': id}, {$set: {'profile.room': doc._id}}, {upsert: true}
  
  insertNotif: (sendto, doc) !->
    if sendto is 0
      Rooms.update {}, {$push: {'notifs': doc}}, {upsert: true}
    else
      Rooms.update {'name': sendto}, {$push: {'notifs': doc}}, {upsert: true}

  updateLast: (id) ->
    Meteor.users.update {'_id': id}, {$set: {'profile.last': new Date!}}, {upsert: true}
}