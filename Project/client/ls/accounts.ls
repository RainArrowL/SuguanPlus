Template.signin.events {
  'submit #signin-form': (e, t) !->
    e.prevent-default!

    phone = t.find '#signin-phone' .value
    password = if $ '#fake-password' .has-class 'ui-yick-show' then t.find '#fake-password' .value else t.find '#signin-password' .value


    Meteor.login-with-password phone, password, (err)->
      if err then alert 'error'
      else
        console.log 'success'
        Router.go '/'

  'click #js-yick-eye': (e, t) !->
    tg = $ e.target
    fp = $ '#fake-password'
    tg.toggle-class 'ion-ios-eye' .toggle-class 'ion-ios-eye-outline'
    fp.toggle-class 'ui-yick-show'
    if not fp.has-class 'ui-yick-show'
      ori = fp.val!
      $ '#signin-password' .val ori
    else
      ori = $ '#signin-password' .val!
      fp.val ori
}

Template.signup.events {
  'submit #signup-form': (e, t) !->
    e.prevent-default!

    phone = t.find '#account-phone' .value
    password = if $ '#fake-password' .has-class 'ui-yick-show' then t.find '#fake-password' .value else t.find '#account-password' .value
    name = t.find '#account-name' .value
    level = t.find '#account-level' .value
    console.log phone
    console.log password
    Accounts.create-user {username: phone, password: password, profile: {name: name, level: +level}}, (err)->
      if err then console.log err
      else
        console.log 'success'
        Router.go '/'

  'click #back-btn': (e, t) !->
    history.back!

  'click #js-yick-eye': (e, t) !->
    tg = $ e.target
    fp = $ '#fake-password'
    tg.toggle-class 'ion-ios-eye' .toggle-class 'ion-ios-eye-outline'
    fp.toggle-class 'ui-yick-show'
    if not fp.has-class 'ui-yick-show'
      ori = fp.val!
      $ '#account-password' .val ori
    else
      ori = $ '#account-password' .val!
      fp.val ori
}

Template.layout.helpers {
  isStudent: ->
    Meteor.user!.profile.level is 0
}
