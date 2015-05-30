Template.signin.events {
  'submit #signin-form': (e, t) !->
    e.prevent-default!

    phone = t.find '#signin-phone' .value
    password = t.find '#signin-password' .value


    Meteor.login-with-password phone, password, (err)->
      if err then alert 'error'
      else
        console.log 'success'
        Router.go '/'
}

Template.signup.events {
  'submit #signup-form': (e, t) !->
    e.prevent-default!

    phone = t.find '#account-phone' .value
    password = t.find '#account-password' .value
    name = t.find '#account-name' .value
    level = t.find '#account-level' .value
    console.log phone
    console.log password
    Accounts.create-user {username: phone, password: password, profile: {name: name, level: +level}}, (err)->
      if err then console.log err
      else
        console.log 'success'
        Router.go '/'
}

Template.layout.helpers {
  isStudent: ->
    Meteor.user!.profile.level is 0
}
