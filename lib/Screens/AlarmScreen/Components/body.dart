// ignore_for_file: deprecated_member_use, unused_field, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylastwords/Screens/AlarmScreen/Components/alarm_helper.dart';
import 'package:mylastwords/components/input_dialogue.dart';
import 'package:mylastwords/components/rounded_button.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/components/header_tab.dart';
import 'package:mylastwords/main.dart';
import 'package:path/path.dart';

import '../../../data.dart';
import 'package:mylastwords/models/alarm_info.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<String> _days = [];
  List<bool> _isChecked = [false, false, false, false, false, false, false]; 
  List<String> _texts = [
    "Monday",
    "Teusday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  final TextEditingController txtInputTitle = TextEditingController();
  String title = "";
  DateTime? _alarmTime;
  String? _alarmTimeString;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  List<AlarmInfo>? _currentAlarms;
  var generateId = Uuid();

  @override
  void initState() {
    title = "Title";
    _alarmTime = DateTime.now();
    _alarmHelper.initializaDatabase().then((value) {
      ToastMessage().toastMsgLight('Database Initialized');
      loadAlarms();
    });
    _alarmTimeString ??= DateFormat('hh:mm aa').format(DateTime.now());
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
   
    return Scaffold(
      appBar: HeaderTab(
        backgroundcolor: headerBackgroundColor,
        title: 'Alarm',
        iconbtn: Icons.alarm_add_rounded,
        press: () {
          showModalBottomSheet(
            useRootNavigator: true,
            context: context,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setModalState) {
                  return Container(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        FlatButton(
                          onPressed: () async {
                            var selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (selectedTime != null) {
                              final now = DateTime.now();
                              var selectedDateTime = DateTime(
                                  now.year,
                                  now.month,
                                  now.day,
                                  selectedTime.hour,
                                  selectedTime.minute);
                              _alarmTime = selectedDateTime;
                              setModalState(() {
                                _alarmTimeString = DateFormat('hh:mm aa')
                                    .format(selectedDateTime);
                              });
                            }
                          },
                          child: Text(
                            _alarmTimeString!,
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                        ListTile(
                            title:  Text(
                                  'Repeat',
                                  style: TextStyle(
                                      color: txtColorDark,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: (){                       
                                  showDialog(    
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Repeat'),
                                        content: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height * 0.4,
                                          child: Column(         
                                            children: [
                                              Expanded(
                                                child: ListView(
                                                    shrinkWrap: true,            
                                                    children: [
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: _texts.length,
                                                        itemBuilder: (_, index) {
                                                          return CheckboxListTile(
                                                            title: Text(_texts[index]),
                                                            value: _isChecked[index],
                                                            onChanged: (val) {
                                                              setState(() {
                                                                _isChecked[index] = val!;                                                                                                                            
                                                              });
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          SizedBox(
                                              width: MediaQuery.of(context).size.width,
                                              child: RaisedButton(
                                                color: Colors.blue,
                                                onPressed: (){                 
                                                  for(var i = 0; i < _texts.length; i++)
                                                  {
                                                    if(_isChecked[i] == true)
                                                    {
                                                      print(_texts[i].toString());                                                    
                                                    }
                                                  }
                                                  Navigator.pop(context);},
                                                child: Text('Select'),
                                              ))
                                        ],
                                      );
                                    },
                                  );
                              },
                        ),
                        ListTile(
                          title:  Text(
                                  'Sound',
                                  style: TextStyle(
                                      color: txtColorDark,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        ListTile(
                          title:  Text(
                                  title,
                                  style: TextStyle(
                                      color: txtColorDark,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () { showDialog(                            
                          context: context,
                          barrierColor: Colors.black.withOpacity(.4),
                          builder: (context) {
                            return AlertDialog(
                                    title: Text('Title'),
                                        content: TextField(
                                          onChanged: (value) {     
                                          },
                                          controller: txtInputTitle,
                                          decoration: InputDecoration(hintText: "Enter here"),
                                        ),
                                        actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                            setModalState(() {
                                                       title = txtInputTitle.text;  });
                                           Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Ok',
                                          style: TextStyle(color: txtColorDark, fontSize: 15),
                                        ),
                                      ),
                                  
                                    ],
                                  );
                          },
                        );},
                        ),                     
                        FloatingActionButton.extended(
                          backgroundColor: darkBackground,
                          onPressed: () async {
                       
                            var idStr = DateFormat('MMddHHmmss')
                                    .format(DateTime.now());
                            var alarmInfo = AlarmInfo(                              
                                id: int.parse(idStr),
                                title: title,
                                alarmDateTime: _alarmTime,
                                alarmOnOff: "true");

                            _alarmHelper.insertAlarm(alarmInfo);
                            _alarmHelper.scheduleAlarm(
                                _alarmTime!, alarmInfo);
                            Navigator.pop(context);
                            loadAlarms();
                          },
                          icon: Icon(Icons.alarm),
                          label: Text('Save Alarm'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      backgroundColor: darkBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),
          Expanded(
            child: FutureBuilder<List<AlarmInfo>>(
              future: _alarms,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _currentAlarms = snapshot.data;
                  if(_currentAlarms!.length<=0){
                      return Center(
                        child: Center(
                          child:    Text(
                                      'No Alarms',
                                      style: TextStyle(
                                        color: txtColorLight,
                                        fontSize: 30,
                                      ),
                                    ),
                        ),
                      );
                  }
                  else{
                  return ListView(
                    children: snapshot.data!.map<Widget>((alarm) {
                      var alarmTime =
                          DateFormat('hh:mm aa').format(alarm.alarmDateTime!);
                      bool onOff=true;
                      Color? txtColors;
                      if(alarm.alarmOnOff=='true'){
                        onOff=true;
                        txtColors = txtColorDark;
                        }
                        else if( alarm.alarmOnOff=='false'){
                           onOff=false;
                           txtColors = Colors.grey;
                        }                                         
                      return Container(
                        margin: const EdgeInsets.only(
                            bottom: 12, left: 15, right: 15),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [kPrimaryLightColor, lightBackground],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [],
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.label,
                                      color: txtColors,
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      alarm.title!,
                                      style: TextStyle(
                                        color: txtColors,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Switch(
                                    value: onOff,
                                    onChanged: (bool value) {                                    
                                      if(alarm.alarmOnOff=='true'){                                                                            
                                         _alarmHelper.updateOnOff(AlarmInfo(id: alarm.id, title: alarm.title, alarmDateTime: alarm.alarmDateTime, alarmOnOff: 'false'));  
                                         loadAlarms();
                                         _alarmHelper.unScheduleAlarm(AlarmInfo(id: alarm.id));
                                      }
                                      else if(alarm.alarmOnOff=='false'){                                        
                                          _alarmHelper.updateOnOff(AlarmInfo(id: alarm.id, title: alarm.title, alarmDateTime: alarm.alarmDateTime, alarmOnOff: 'true')); 
                                          loadAlarms();
                                       _alarmHelper.scheduleAlarm(_alarmTime!, AlarmInfo(id: alarm.id, title: alarm.title, alarmDateTime: alarm.alarmDateTime, alarmOnOff: alarm.alarmOnOff));
                                        
                                      }
                                    print(alarm.alarmOnOff)                                   ;
                                    },
                                    activeColor: txtColorDark),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Monday to Friday',
                                  style: TextStyle(
                                      color: txtColors,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(children: [  Text(
                                  alarmTime,
                                  style: TextStyle(
                                      color: txtColors,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),],),
                                Row(mainAxisAlignment: MainAxisAlignment.end,
                                  children: [IconButton(
                                    icon: Icon(Icons.edit),
                                    color: txtColors,
                                    alignment: Alignment.centerRight,
                                    onPressed: () {
                                      showModalBottomSheet(
                                        useRootNavigator: true,
                                        context: context,
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(24),
                                          ),
                                        ),
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (context, setModalState) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(32),
                                                child: Column(
                                                  children: [
                                                    FlatButton(
                                                      onPressed: () async {
                                                        var selectedTime =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                        );
                                                        if (selectedTime !=
                                                            null) {
                                                          final now =
                                                              DateTime.now();
                                                          var selectedDateTime =
                                                              DateTime(
                                                                  now.year,
                                                                  now.month,
                                                                  now.day,
                                                                  selectedTime
                                                                      .hour,
                                                                  selectedTime
                                                                      .minute);
                                                          _alarmTime =
                                                              selectedDateTime;
                                                          setModalState(() {
                                                            _alarmTimeString =
                                                                DateFormat(
                                                                        'hh:mm aa')
                                                                    .format(
                                                                        selectedDateTime);
                                                          });
                                                        }
                                                      },
                                                      child: Text(
                                                        _alarmTimeString!,
                                                        style: TextStyle(
                                                            fontSize: 32),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Text('Repeat'),
                                                      trailing: Icon(Icons
                                                          .arrow_forward_ios),
                                                    ),
                                                    ListTile(
                                                      title: Text('Sound'),
                                                      trailing: Icon(Icons
                                                          .arrow_forward_ios),
                                                    ),
                                                    ListTile(
                                                      title: Text(title),
                                                      trailing: Icon(Icons
                                                          .arrow_forward_ios),
                                                    ),
                                                    FloatingActionButton
                                                        .extended(
                                                      backgroundColor:
                                                          darkBackground,
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(Icons.alarm),
                                                      label: Text('Save Alarm'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    }),
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    color: txtColors,
                                    onPressed: () {
                                      _alarmHelper.delete(alarm.id!);
                                      loadAlarms();
                                    }),],),
                              
                                
                              ],
                            ),                            
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }
              }
                return Center(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
    
