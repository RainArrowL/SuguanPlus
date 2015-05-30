/**
 * Routes
 * -------------------------------------------------------------------------------
 * | /        | index          | if not signin, jump to signin
 * |          |                | else if admin, jump to admin center(data: building)
 * |          |                | else reisident center(data: room)
 * | /signin  | signin         |
 * | /signup  | signup         |
 * | /signout | signout        |
 * | /table   | charge         | data: building, template: table
 * | /post    | post msg       | template: post, # (公告)
 * | /create  | create a bu-   | template: create
 * |          | ilding or room |
 * | /join    | join in r or b | template: joinin
 * -------------------------------------------------------------------------------
 */

config =
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'

Router.configure config

Router.route '/', !->
  current-level = Meteor.user!.profile.level
  if current-level is 1
    @render 'admin-index', {
      'data': ->
    }
  else
    @render 'student-index', {
      'data': ->
    }
  #todo


Router.route '/me', !->
  current-level = Meteor.user!.profile.level
  if current-level is 1
    @render 'admin-me', {
      'data': ->
    }
  else
    @render 'student-me', {
      'data': ->
    }

# Accounts
Router.route '/signin', !->
  @render 'signin', {
    'data': ->
  }
  #todo

Router.route '/signup', !->
  @render 'signup'

Router.route '/signout', !->
  #todo



Router.route '/table', !->
  @render 'table', {
    'data': ->
      #find building in db
  }

Router.route '/post', !->
  @render 'post'

Router.route '/create', !->
  if Meteor.user!.profile.level is 1
    @render 'create-building', {
      'data': ->
    }
  else
    @render 'create-room', {
      'data': ->
    }


Router.route '/join', !->
  @render 'join'

Router.route '/msg', !->
  @render 'message-page', {
    'data': ->
      doc = Rooms.find-one {'_id': Meteor.user!.profile.room}
      {'msglist': doc.notifs}
  }

Router.route 'logout', !->
  Meteor.logout!
  @redirect '/signin'

# Route.route '/'
require-login = !->
  if not Meteor.user! then @redirect '/signin'
  else @next!

# Router.on-before-action 'dataNotFound', all

Router.on-before-action require-login, except: ['signin', 'signup']

root = exports ? @
root.Router = Router
