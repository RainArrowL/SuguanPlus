Template.create-building.events {
  'submit #create-building': (e, t) !->
    e.prevent-default!

    building-name = t.find '#building-name' .value

    Meteor.call 'insertBuilding', Meteor.user-id!, building-name

}

Template.post.events {
  'submit #post-form': (e, t) !->
    e.prevent-default!

    sendto = t.find '#sendto' .value
    subject = t.find '#subject' .value
    content = t.find '#content' .value

    doc =
      subject: subject
      content: content
      time: new Date!

    sendto = sendto.split(';')
    for i in sendto
      Meteor.call 'insertNotif', +i, doc
}