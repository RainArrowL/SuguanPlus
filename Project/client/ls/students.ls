Template.createRoom.events {
  'submit #create-room': (e, t) !->
    e.prevent-default!

    building-name = t.find '#building-name' .value
    room-name = t.find '#room-name' .value

    Meteor.call 'insertRoom', Meteor.user-id!, +room-name, building-name
    Router.go '/'

  'click #back-btn': (e, t) !->
    history.back!
}

Template.join.events {
  'submit #join': (e, t) !->
    e.prevent-default!

    building-name = t.find '#building-name' .value
    room-name = t.find '#room-name' .value

    Meteor.call 'joinRoom', Meteor.user-id!, +room-name, building-name
}

Template.message-page.helpers {
  dateToString: (d)->
    d.to-date-string!
  isCat: (cat, p)->
    if +p.cat is 4 then true else +p.cat is +cat
}


Template.student-top-bar.helpers {
  getRoomName: (rid)->
    doc = Rooms.find-one {'_id': rid}
    "#{doc.building} #{doc.name}"
}

Template.student-me.helpers {
  getRoomName: (rid)->
    doc = Rooms.find-one {'_id': rid}
    "#{doc.building} #{doc.name}"
}

Template.message-page.rendered = !->
  Meteor.call 'updateLast', Meteor.user-id!


Template.student-tabs.helpers {
  notifCount: ->
    doc = Rooms.find-one {'_id': Meteor.user!.profile.room}
    s = 0
    for noti in doc.notifs
      if noti.time > Meteor.user!.profile.last
        s++
    s

  isMe: ->
    Router.current!.url is '/me'

  isMsg: ->
    flag = Router.current!.url.index-of '/msg'
    flag > -1

  isHome: ->
    Router.current!.url is '/'
}


Template.message-top-bar.helpers {
  isCat0: -> Router.current!.url is '/msg/category/0'
  isCat1: -> Router.current!.url is '/msg/category/1'
  isCat4: -> Router.current!.url is '/msg/category/4'
}

Template.message-top-bar.events {
  'click .js-yick-tab': (e, t) !->
    tg = $ e.target
    which = tg.attr 'aria-controls' .replace 'tab', ''
    Router.go "/msg/category/#{which}"
}

Template.student-index.helpers {
  dateToString: (d)->
    d.to-date-string!
}