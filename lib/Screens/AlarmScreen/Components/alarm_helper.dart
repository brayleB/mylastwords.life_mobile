// ignore_for_file: unused_field, import_of_legacy_library_into_null_safe, deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
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
final String colSound = 'sound';

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
            $colRepeat TEXT NOT NULL,
            $colSound TEXT NOT NULL
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
    print('result : ' + result.toString());
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

  Future<int> updatealarm(int id, String rep) async {
    var db = await this.database;
    unScheduleAlarm(AlarmInfo(id: id, repeat: rep));
    return await db!.delete(tblAlarm, where: '$colId=?', whereArgs: [id]);
  }

  Future<int> delete(int id, String rep) async {
    var db = await this.database;
    unScheduleAlarm(AlarmInfo(id: id, repeat: rep));
    return await db!.delete(tblAlarm, where: '$colId=?', whereArgs: [id]);
  }

  Future<int> updateOnOff(AlarmInfo alarmInfo) async {
    var db = await this.database;
    return await db!.update(tblAlarm, alarmInfo.toMap(),
        where: 'id=?', whereArgs: [alarmInfo.id]);
  }

  Future<int> updateAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    return await db!.update(tblAlarm, alarmInfo.toMap(),
        where: 'id=?', whereArgs: [alarmInfo.id]);
  }

  void scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      alarmInfo.id.toString(),
      alarmInfo.title.toString(),
      playSound: true,
      sound: RawResourceAndroidNotificationSound(alarmInfo.sound),
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
      enableLights: true,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: alarmInfo.sound! + '.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        alarmInfo.id!,
        'mylastwords.life',
        alarmInfo.title,
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  void scheduleAlarmRepeated(Day day, Time time, AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      alarmInfo.id.toString(),
      alarmInfo.title.toString(),
      playSound: true,
      sound: RawResourceAndroidNotificationSound(alarmInfo.sound),
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
      enableLights: true,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: alarmInfo.sound! + '.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        alarmInfo.id!,
        'mylastwords.life',
        alarmInfo.title,
        day,
        time,
        platformChannelSpecifics);
  }

  void unScheduleAlarm(AlarmInfo alarmInfo) async {
    if (alarmInfo.repeat == "No Repeat") {
      await flutterLocalNotificationsPlugin.cancel(alarmInfo.id!);
      print('Unscheduled alarm: ' + alarmInfo.id.toString());
    } else {
      int x = 0;
      List<String> reps = alarmInfo.repeat!.split(", ");
      List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      for (var i = 0; i < days.length; i++) {
        if (reps[x] == days[i]) {
          String idToString = alarmInfo.id.toString();
          String tempId = idToString + i.toString();
          int legitId = int.parse(tempId);
          await flutterLocalNotificationsPlugin.cancel(legitId);
          print('Unscheduled alarm: ' + legitId.toString());
          if (x < reps.length - 1) {
            x++;
          }
        }
      }
    }
  }
}
