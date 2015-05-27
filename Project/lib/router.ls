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
  #todo


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

Router.route 'create', !->
  @render 'create'

Router.route 'join', !->
  @render 'join'

# Route.route '/'
require-login = !->
  if not Meteor.user! then @render 'signin'
  else @next!

get-level = !->
  @next!

# Router.on-before-action 'dataNotFound', all

Router.on-before-action require-login, except: ['signin', 'signup']

root = exports ? @
root.Router = Router
