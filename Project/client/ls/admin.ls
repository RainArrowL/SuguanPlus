Template.create-building.events {
  'submit #create-building': (e, t) !->
    e.prevent-default!

    building-name = t.find '#building-name' .value

    Meteor.call 'insertBuilding', Meteor.user-id!, building-name

}


Template.btnGrid.helpers {
  getRoomNum: (pc, room) ->
    console.log pc.flr
    pc.flr*100+room
}

Template.adminIndex.events {
  'click #edit-btn': (e, t) !->
    tg = $ e.target
    $ '.ui-yick-toggle-panel' .toggle-class 'ui-yick-show'
    if tg.text! is '编辑'
      tg.text '取消'
      $ '.ui-item' .add-class 'ui-yick-edit-item'
      $ '.ui-yick-edit-icon' .add-class 'ui-yick-show' .remove-class 'ion-ios-checkmark' .add-class 'ion-ios-circle-outline'
    else
      tg.text '编辑'
      $ '.ui-yick-item-panel button' .remove-class 'ui-yick-btn-active'
      $ '.ui-item' .remove-class 'ui-yick-edit-item'
      $ '.ui-yick-edit-icon' .remove-class 'ui-yick-show' .remove-class 'ion-ios-checkmark' .add-class 'ion-ios-circle-outline'

  'click .ui-yick-edit-icon': (e, t) !->
    tg = $ e.target
    tg.toggle-class 'ion-ios-circle-outline'
    tg.toggle-class 'ion-ios-checkmark'

    if tg.has-class 'ion-ios-checkmark'
      tg.parent!.find 'button' .add-class 'ui-yick-btn-active'
    else
      tg.parent!.find 'button' .remove-class 'ui-yick-btn-active'

  'click .ui-item a': (e, t) !->
    tg = $ e.target
    tg.parent!.find '.ui-yick-item-panel' .toggle-class 'ui-yick-show'
    tg.parent!.toggle-class 'ui-yick-open'
  
  'click .ui-yick-item-panel button': (e, t) !->
    tg = $ e.target
    state-text = $ '#edit-btn'
    if  state-text.text! is '取消'
      e.prevent-default!
      tg.toggle-class 'ui-yick-btn-active'
    else
      $ '.js-backdrop' .add-class 'js-show'
      $ '#myActionsheet' .add-class 'js-show' .css 'display', 'block'

  'click .ui-actionsheet-cancel': (e, t) !->
    $ '.js-backdrop' .remove-class 'js-show'
    $ '#myActionsheet' .remove-class 'js-show' .css 'display', 'none'

  'click #send-button': (e, t) !->
    rooms = $ '.ui-yick-btn-active'
    param = [$ room .text!.trim! for room in rooms].join ';'
    Router.go "/post/#{param}"
}


Template.post.events {
  
  'click #back-btn': (e, t) !->
    $ '.js-backdrop' .add-class 'js-show'
    $ '#myAlert' .css 'display', 'block'
  
  'click #alert-cancel': (e, t) !->
    $ '.js-backdrop' .remove-class 'js-show'
    $ '#myAlert' .css 'display', 'none'
  
  'click #alert-confirm': (e, t) !->
    $ '.js-backdrop' .remove-class 'js-show'
    $ '#myAlert' .css 'display', 'none'
    history.back!
  
  'change #category': (e, t) !->
    tg = $ e.target
    if +tg.val! is 2 then $ '#sendto' .val '全体成员'
    else $ '#sendto' .val ''
    if +tg.val! is 0 
      $ 'html' .add-class 'js-effect-from-top'
      $ '#myNotify' .show! .add-class 'js-show'
    timer = set-timeout (!-> $ '#myNotify' .hide!) , 2000

  'submit #post-form': (e, t) !->
    e.prevent-default!

    # sendto 需要注意不能包含不存在的宿舍
    sendto = t.find '#sendto' .value
    subject = t.find '#subject' .value
    content = t.find '#content' .value
    category = t.find '#category' .value
    
    if +category is 2 then sendto = 0

    doc =
      subject: subject
      content: content
      category: +category
      time: new Date!

    sendto = sendto.split(';')
    for i in sendto
      Meteor.call 'insertNotif', +i, doc
}