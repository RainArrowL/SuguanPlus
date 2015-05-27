# Accounts.ui.config {
#   request-permissions: {},
#   password-signup-fields: 'USERNAME_ONLY'
#   extra-signup-fields:
#     * field-name: 'level'
#       field-label: '身份'
#       input-type: 'text'
#       visible: true
#       validate: -> true
#     * field-name: 'roomCode'
#       field-label: '房间代号'
#       input-type: 'number'
#       visible: true
#       validate: -> true
# }
# 
if Meteor.is-client
  Template.signin.events {
    'submit #signin-form': (e, t) !->
      e.prevent-default!

      phone = t.find '#signin-phone' .value
      password = t.find '#signin-password' .value


      Meteor.login-with-password phone, password, (err)->
        if err then alert 'error'
        else console.log 'success'
  }

  Template.signup.events {
    'submit #signup-form': (e, t) !->
      e.prevent-default!

      phone = t.find '#account-phone' .value
      password = t.find '#account-password' .value
      name = t.find '#account-name' .value
      console.log phone
      console.log password
      Accounts.create-user {username: phone, password: password, profile: {name: name}}, (err)->
        if err then console.log err
        else console.log 'success'
  }
