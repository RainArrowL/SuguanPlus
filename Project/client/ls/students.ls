Template.createRoom.events {
  'submit #create-room': (e, t) !->
    e.prevent-default!

    building-name = t.find '#building-name' .value
    room-name = t.find '#room-name' .value

    Meteor.call 'insertRoom', Meteor.user-id!, +room-name, building-name
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
    Router.current!.url is '/msg'

  isHome: ->
    Router.current!.url is '/'
}

Template.admin-tabs.helpers {
  isMe: ->
    Router.current!.url is '/me'

  isCharge: ->
    Router.current!.url is '/charge'

  isMsg: ->
    Router.current!.url is '/msg'

  isHome: ->
    Router.current!.url is '/'
}