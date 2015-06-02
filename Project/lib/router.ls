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
        d = {'building': []}
        for i in [1 to 30]
          if (i-1) % 5 is 0 then d['building'].push {'floor': []}
          d['building'][Math.floor (i-1)/5]['floor'].push {'room': i}
        d
    }
  else
    @render 'student-index', {
      'data': ->
        if Meteor.user!.profile.room
          doc = Rooms.find-one {'_id': Meteor.user!.profile.room}
          notice = []
          other = []
          n-count = 0
          o-count = 0
          for i in doc.notifs
            if n-count is 1 and o-count is 3 then break
            if i.category is 1
              notice.push i
              n-count += 1
            else
              other.push i
              o-count += 1
          d = {'notice': notice, 'other': other}
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

Router.route '/post/:sendto', !->
  @layout 'noTabLayout'
  @render 'post' , {
    data: ->
      {sendto: @params.sendto, noTab: true}
  }

Router.route '/post', !->
  @layout 'noTabLayout'
  @render 'post' , {
    data: ->
      {sendto: "", noTab: true}
  }

Router.route '/create', !->
  @layout 'noTabLayout'
  if Meteor.user!.profile.level is 1
    @render 'create-building', {
      'data': ->
    }
  else
    @render 'create-room', {
      'data': ->
        console.log(Buildings.find!.count!)

        {buis: Buildings.find!}
        
    }


Router.route '/join', !->
  @render 'join'

Router.route '/msg/category/:cat', !->
  cat = +@params.cat
  @render 'message-page', {
    'data': ->
      doc = Rooms.find-one {'_id': Meteor.user!.profile.room}
      {'msglist': doc.notifs, 'cat': cat}
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
