// ignore_for_file: unused_field, import_of_legacy_library_into_null_safe

import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/models/alarm_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mylastwords/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mylastwords/main.dart';

final String tblAlarm = 'alarm';
final String colId = 'id';
final String colTitle = 'title';
final String colDateTime = 'alarmDateTime';
final String colalarmOnOff = 'alarmOnOff';
final String colRepeat = 'repeat';


class AlarmHelper {
  static Database? _database;
  static AlarmHelper? _alarmHelper;

  AlarmHelper._createInstance();
  factory AlarmHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper._createInstance();
    }
    return _alarmHelper!;
  }

  Future<Database?> get database async {
    if (_database == null) { 
      _database = await initializaDatabase();
    }   
    return _database;
  }

  Future<Database?> initializaDatabase() async {
   
    var dir = await getDatabasesPath();
    var path = dir + "/alarm.db";
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tblAlarm 
          (
            $colId INTEGER PRIMARY KEY,
            $colTitle TEXT NOT NULL,
            $colDateTime TEXT NOT NULL,
            $colalarmOnOff TEXT NOT NULL,
            $colRepeat TEXT NOT NULL
          )
        ''');
      },
    );
    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    var result = await db!.insert(tblAlarm, alarmInfo.toMap());      
    ToastMessage().toastMsgLight('Successfully Added Alarm');   
    print('result : $result');
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];
    var db = await this.database;
    var result = await db!.query(tblAlarm);    
    result.forEach((element) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);
    });
    return _alarms;    
  }

  Future<int> delete(int id) async {
     var db = await this.database;
        ToastMessage().toastMsgLight("Successfully Deleted Alarm");
    return await db!.delete(tblAlarm, where: '$colId=?',whereArgs: [id]);
  }

  Future<int> updateOnOff(AlarmInfo alarmInfo) async {
    var db  = await this.database;          
    return await db!.update(tblAlarm, alarmInfo.toMap(), where: 'id=?',whereArgs: [alarmInfo.id]);    
  }

   

  void scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',        
        presentAlert: true,
        presentBadge: true,
        presentSound: true,);
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(alarmInfo.id, 'mylastwords.life', alarmInfo.title,
        scheduledNotificationDateTime, platformChannelSpecifics);
    print('Scheduled alarm: ' + alarmInfo.id.toString());
  }

  void unScheduleAlarm(AlarmInfo alarmInfo)async{
    await flutterLocalNotificationsPlugin.cancel(alarmInfo.id);
    print('Unscheduled alarm: ' + alarmInfo.id.toString());
  }
}
