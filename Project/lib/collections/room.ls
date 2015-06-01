/**
 * @brief 房间数据模型
 *
 * @param name {Number} 房间号
 * @param building {String} 楼栋名称
 * @param notifs {Array} 宿舍接收的消息通知
 *        @param content {String} 消息内容
 *        @param subject {String} 消息主题
 *        @param category {Number} 消息类别 0:缴费消息  1:快件消息 2:公告
 *        @param time {Date} 发送时间（与users.last共同判断是否已读）
 */

Rooms = new Mongo.Collection 'rooms'

Rooms.allow {
	insert: (username, doc) -> username?
}

root = exports ? @
root.Rooms = Rooms


/**
 * { "_id" : "WkjHugJcSi7Ttto7X",
 *   "createdAt" : ISODate("2015-05-30T08:34:17.598Z"),
 *   "services" : {
 *       "password" : {
 *           "bcrypt" : "$2a$10$ScbNsi6TLNRPn5fIG6h1UexD2UwmMO2IGE8BO2.cPNl7B6.8dtimK"
 *       },
 *       "resume" : { "loginTokens" : [ { "when" : ISODate("2015-05-30T09:14:32.390Z"), "hashedToken" : "aRK98ie0h3cWN/nGt4cbU+xIs+E2Ekc5Q97tShbVZdA=" }, { "when" : ISODate("2015-05-31T11:44:44.974Z"), "hashedToken" : "Sm3RBRFwFGGMil4bKmx0Sbl9Jb3MmDyYwXFDYm+JVsY=" } ] } },
 *       # 这里来时才是自定义的字段，上面自动生成的
 *       "username" : "10087",
 *       "profile" : {
 *           "name" : "学生",
 *           "level" : 0, // 0 代表学生
 *           "room" : "6QHrzTAmGnihdyxFo", // 房间的_id
 *           "last" : ISODate("2015-06-01T13:20:31.752Z") 
 *       }
 *  }
 */