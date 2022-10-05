// ignore_for_file: deprecated_member_use, unused_field, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mylastwords/Background/tracker.dart';
import 'package:mylastwords/Screens/AlarmScreen/Components/alarm_helper.dart';
import 'package:mylastwords/Screens/advisory.dart';
import 'package:mylastwords/components/drawer.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/components/header_tab.dart';
import 'package:mylastwords/models/alarm_info.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<String> fileExtensions = ['.wav','.mp3'];  
  List<String> _texts = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun",];
  List<Day> _dayDates = [Day.monday,Day.tuesday,Day.wednesday,Day.thursday,Day.friday,Day.saturday,Day.sunday];
  List<String> alarmSoundFiles = ["longcold","rainyday","electronic","fantasy","niceday","latin","synergetic","wakeup","positive"];
  List<String> _alarmSoundList = ["Cold","Rainy Day","Electronic","Fantasy","Nice Day","Latin","Synergetic",    "Wake Up","Positive"];
  final TextEditingController txtInputTitle = TextEditingController();
  String title = "";
  String txtRepeat = "";
  String txtSound = "";
  String txtSoundDisplay = "";
  DateTime? _alarmTime;
  String? _alarmTimeString;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  List<AlarmInfo>? _currentAlarms;
  String? selectedValue;
  final player = AudioPlayer();
  bool? hasUser;

  final _timePickerTheme = TimePickerThemeData(
  backgroundColor: darkBackground,
  hourMinuteShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: ColorTheme1, width: 1),
  ),
  dayPeriodBorderSide: const BorderSide(color: darkBackground, width: 4),
  dayPeriodColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected) ? ColorTheme2 : Colors.blueGrey.shade800),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    side: BorderSide(color: ColorTheme1, width: 2),
  ),
  dayPeriodTextColor: MaterialStateColor.resolveWith(
      (states) => states.contains(MaterialState.selected) ? ColorTheme10 : ColorTheme2),
  dayPeriodShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: ColorTheme1, width: 1),
  ),
  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected) ? ColorTheme2 : Colors.blueGrey.shade800),
  hourMinuteTextColor: MaterialStateColor.resolveWith(
      (states) => states.contains(MaterialState.selected) ? ColorTheme10 : ColorTheme2),
  dialHandColor: Colors.blueGrey.shade700,
  dialBackgroundColor: Colors.blueGrey.shade800,
  hourMinuteTextStyle: const TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
  dayPeriodTextStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
  helpTextStyle:
      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(0),
  ),
  dialTextColor: MaterialStateColor.resolveWith(
      (states) => states.contains(MaterialState.selected) ? ColorTheme2 : Colors.white),
  entryModeIconColor: ColorTheme1,
);

  @override
  void initState() {
    checkUser();
    title = "Hello";
    txtRepeat = "No Repeat";
    txtSoundDisplay = "Cold";
    txtSound = "longcold";
    _alarmTime = DateTime.now();
    _alarmHelper.initializaDatabase().then((value) {      
      loadAlarms();
    });
    _alarmTimeString ??= DateFormat('hh:mm aa').format(DateTime.now());        
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  void checkUser() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     bool? errorserver = prefs.getBool('error_server');
     if(errorserver==true){
       setState(() {
         hasUser=false;
       });
     }
     else{
        setState(() {
         hasUser=true;
       });
     }
  }

  
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;  
    return Scaffold(
      drawer: hasUser == true ? DrawerScreen() : AdvisoryScreen(),
      appBar: AppBar(        
        backgroundColor: headerBackgroundColor,
        title: Text('Alarms'),         
      ),
      backgroundColor: darkBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 25),
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
                      Color? bgColors;
                      if(alarm.alarmOnOff=='true'){
                        onOff=true;
                        txtColors = txtColorDark;
                        bgColors = lightBackground;
                        }
                        else if( alarm.alarmOnOff=='false'){
                           onOff=false;
                           txtColors = Colors.black.withOpacity(0.7);
                           bgColors = headerBackgroundColor;
                        }         

                        return GestureDetector(
                        onTap: () {
                          var editAlarmString = DateFormat('hh:mm aa').format(alarm.alarmDateTime!);
                          var txtEditRepeat = alarm.repeat.toString();
                          var txtEditSound = alarm.sound.toString();
                          var txtEditTitle = alarm.title.toString();
//edit alarm                          
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
                                      padding: const EdgeInsets.all(30),
                                      child: Column(
                                        children: [
                                          FlatButton(
                                            onPressed: () async {
                                              var selectedTime = await showTimePicker(
                                                                                context: context,
                                                                                initialTime: TimeOfDay(hour: alarm.alarmDateTime!.hour, minute: alarm.alarmDateTime!.minute),
                                                                                builder: (context, child) {
                                                                                  return Theme(
                                                                                    data: Theme.of(context).copyWith(
                                                                                      // This uses the _timePickerTheme defined above
                                                                                      timePickerTheme: _timePickerTheme,
                                                                                      textButtonTheme: TextButtonThemeData(
                                                                                        style: ButtonStyle(
                                                                                          backgroundColor: MaterialStateColor.resolveWith((states) => darkBackground),
                                                                                          foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                                                                                          overlayColor: MaterialStateColor.resolveWith((states) => Colors.deepOrange),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    child: child!,
                                                                                  );
                                                                                },
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
                                                  editAlarmString = DateFormat('hh:mm aa')
                                                      .format(selectedDateTime);
                                                });
                                              }
                                            },
                                            child: Text(
                                              editAlarmString,
                                              style: TextStyle(fontSize: 32),
                                            ),
                                          ),
                                          ListTile(
                                              leading:  Text(
                                                    'Repeat - ',
                                                    style: TextStyle(
                                                        color: txtColorDark,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                              title: Text(
                                                txtEditRepeat,
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
                                                      builder: (context) {
                                                        return StatefulBuilder(builder: (context, setChkState){
                                                          _days.clear();
                                                          return AlertDialog(
                                                          title: Text('Repeat'),
                                                          content: Container(
                                                            width: MediaQuery.of(context).size.width,
                                                            height: MediaQuery.of(context).size.height * 0.9,
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
                                                                              activeColor: headerBackgroundColor,
                                                                              title: Text(_texts[index]),
                                                                              value: _isChecked[index],
                                                                              onChanged: (val) {
                                                                                setChkState(() {
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
                                                                  color: headerBackgroundColor,
                                                                  onPressed: (){                 
                                                                    for(var i = 0; i < _texts.length; i++)
                                                                    {
                                                                      if(_isChecked[i] == true)
                                                                      {                                                      
                                                                        _days.add(_texts[i].toString());                                                                                                      
                                                                      }
                                                                    }
                                                                    setModalState((){
                                                                      if(_days.isEmpty){
                                                                        txtEditRepeat = "No Repeat";
                                                                      }
                                                                      else{
                                                                        txtEditRepeat = _days.toString().replaceAll('[', '').replaceAll(']', '');
                                                                      }
                                                                      
                                                                    });
                                                                    Navigator.pop(context);                                                 
                                                                    },                                                 
                                                                  child: Text(
                                                                    'Select',
                                                                    style: TextStyle(
                                                                        color: txtColorLight),
                                                                  ),
                                                                ))
                                                          ],
                                                        );
                                                        });
                                                      },                                    
                                                    );                                 
                                                },
                                          ),
                                          ListTile(
                                            leading:  Text(
                                                    'Sound  - ',
                                                    style: TextStyle(
                                                        color: txtColorDark,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                            title: Text(
                                                    txtEditSound,
                                                    style: TextStyle(
                                                        color: txtColorDark,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                            trailing: Icon(Icons.arrow_forward_ios),
                                            onTap: () {                                                                   
                                                showDialog(    
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return StatefulBuilder(builder: (context, setSoundState){                                      
                                                          return AlertDialog(                                                         
                                                          content: Container(
                                                            width: MediaQuery.of(context).size.width,
                                                            height: MediaQuery.of(context).size.height,
                                                            child: Column(         
                                                              children: [
                                                                Expanded(
                                                                  child: ListView(
                                                                      shrinkWrap: true,            
                                                                      children: [
                                                                        ListView.builder(
                                                                          shrinkWrap: true,
                                                                          itemCount: _alarmSoundList.length,
                                                                          itemBuilder: (_, index) {
                                                                            return RadioListTile(
                                                                              activeColor: headerBackgroundColor,
                                                                              title: Text(_alarmSoundList[index].toString()),
                                                                              value: alarmSoundFiles[index],
                                                                              groupValue: selectedValue,
                                                                              selected: selectedValue == alarmSoundFiles[index],
                                                                              onChanged: (val) async {                                                           
                                                                                  final duration = await player.setAsset(ringToneBaseUrl + alarmSoundFiles[index] + '.wav');
                                                                                  await player.setClip(end: Duration(seconds: 10));
                                                                                  player.play();  
                                                                                    setSoundState(() {
                                                                                      selectedValue = val.toString();
                                                                                    });
                                                                                    setModalState((){                                                    
                                                                                      txtEditSound = _alarmSoundList[index];
                                                                                    });
                                                                                    print('selected:' + selectedValue.toString());
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
                                                                  color: headerBackgroundColor,
                                                                  onPressed: (){                                                                   
                                                                      if(selectedValue==null){
                                                                        EasyLoading.showInfo('Please choose alarm sound');
                                                                      }else{
                                                                        setSoundState((){
                                                                        txtSound = selectedValue!;
                                                                        selectedValue = _alarmSoundList[0];
                                                                        txtEditSound = "Sound";
                                                                        });                                                   
                                                                        player.stop();
                                                                        Navigator.pop(context);
                                                                      }                                                                                              
                                                                    },                                                 
                                                                  child: Text(
                                                                    'Select',
                                                                    style: TextStyle(
                                                                        color: txtColorLight),
                                                                  ),
                                                                ))
                                                          ],
                                                        );
                                                        });
                                                      },                                    
                                                    );                         
                                            },
                                          ),
                                          ListTile(
                                            leading:  Text(
                                                    'Label    - ',
                                                    style: TextStyle(
                                                        color: txtColorDark,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                              title: Text(
                                                txtEditTitle,
                                                style: TextStyle(
                                                    color: txtColorDark,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            trailing: Icon(Icons.arrow_forward_ios),
                                            onTap: () { 
                                            showDialog(                            
                                            context: context,
                                            barrierColor: Colors.black.withOpacity(.4),
                                            builder: (context) {
                                              return AlertDialog(
                                                      title: Text('Title'),
                                                          content: TextField(
                                                            onChanged: (value) {     
                                                            },
                                                            controller: txtInputTitle,
                                                            decoration: InputDecoration(focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: headerBackgroundColor, width: 1.0),
                                                            ), hintText: "Enter here"),
                                                          ),
                                                          actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                              setModalState(() {
                                                                if(txtInputTitle.text=="")
                                                                {
                                                                  txtEditTitle="Title";
                                                                }
                                                                else
                                                                {
                                                                  txtEditTitle = txtInputTitle.text; 
                                                                }                                             
                                                              });
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              FloatingActionButton.extended(
                                                backgroundColor: headerBackgroundColor,
                                                onPressed: () async {    
                                                  ToastMessage().toastMsgDark('Under development');                                                                        
                                                  // var alarmInfo = AlarmInfo(  
                                                  //     id: alarm.id,                                                                               
                                                  //     title: txtEditTitle,
                                                  //     alarmDateTime: _alarmTime,
                                                  //     alarmOnOff: alarm.alarmOnOff,
                                                  //     repeat: txtEditRepeat,
                                                  //     sound: txtEditSound);

                                                  // _alarmHelper.updateAlarm(alarmInfo);
                                                  // _alarmHelper.scheduleAlarm(
                                                  //     _alarmTime!, alarmInfo);
                                                  // Navigator.pop(context);                            
                                                  // loadAlarms();                                              
                                                },
                                                icon: Icon(Icons.alarm),
                                                label: Text('Update'),
                                              ),
                                              FloatingActionButton.extended(
                                                backgroundColor: headerBackgroundColor,
                                                onPressed: () {Navigator.pop(context);}  ,
                                                icon: Icon(Icons.cancel),
                                                label: Text('Cancel'),
                                              ),
                                          ],),                                    
                                        ],
                                      ),
                                    );
                                  },                          
                                );
                              },
                            );
//end edit alarm                            
                        },
                        child: Container(
                        margin: const EdgeInsets.only(
                            bottom: 12, left: 15, right: 15),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [bgColors!, bgColors],
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
                                         _alarmHelper.updateOnOff(AlarmInfo(id: alarm.id, title: alarm.title, alarmDateTime: alarm.alarmDateTime, alarmOnOff: 'false', repeat: alarm.repeat, sound: alarm.sound));  
                                         loadAlarms();
                                         _alarmHelper.unScheduleAlarm(AlarmInfo(id: alarm.id));
                                      }
                                      else if(alarm.alarmOnOff=='false'){                                        
                                          _alarmHelper.updateOnOff(AlarmInfo(id: alarm.id, title: alarm.title, alarmDateTime: alarm.alarmDateTime, alarmOnOff: 'true', repeat: alarm.repeat, sound: alarm.sound)); 
                                          loadAlarms();
                                       _alarmHelper.scheduleAlarm(_alarmTime!, AlarmInfo(id: alarm.id, title: alarm.title, alarmDateTime: alarm.alarmDateTime, alarmOnOff: alarm.alarmOnOff, repeat: alarm.repeat, sound: alarm.sound));
                                        
                                      }
                                    print(alarm.alarmOnOff)                                   ;
                                    },
                                    activeColor: txtColorDark),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  alarm.repeat.toString(),
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
                                  children: [
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    color: txtColors,
                                    onPressed: () {
                                      _alarmHelper.delete(alarm.id!, alarm.repeat!);
                                      loadAlarms();
                                    }),],),                                                              
                              ],
                            ),                            
                          ],
                        ),
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
//addalarm      
      floatingActionButton: Container(
        height: size.height * 0.17,
        width: size.width * 0.17, 
        margin: EdgeInsets.only(right: size.width*0.05),      
        child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(  
                backgroundColor: lightBackground,                          
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
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            FlatButton(
                              onPressed: () async {
                                var selectedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          // This uses the _timePickerTheme defined above
                                          timePickerTheme: _timePickerTheme,
                                          textButtonTheme: TextButtonThemeData(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateColor.resolveWith((states) => darkBackground),
                                              foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                                              overlayColor: MaterialStateColor.resolveWith((states) => Colors.deepOrange),
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
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
                                leading:  Text(
                                      'Repeat - ',
                                      style: TextStyle(
                                          color: txtColorDark,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                title: Text(
                                  txtRepeat,
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
                                        builder: (context) {
                                          return StatefulBuilder(builder: (context, setChkState){
                                            _days.clear();                                         
                                            return AlertDialog(
                                            title: Text('Repeat'),
                                            content: Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: MediaQuery.of(context).size.height * 0.9,
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
                                                                activeColor: headerBackgroundColor,
                                                                title: Text(_texts[index]),
                                                                value: _isChecked[index],
                                                                onChanged: (val) {
                                                                  setChkState(() {
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
                                                    color: headerBackgroundColor,
                                                    onPressed: (){                 
                                                      for(var i = 0; i < _texts.length; i++)
                                                      {
                                                        if(_isChecked[i] == true)
                                                        {                                                      
                                                          _days.add(_texts[i].toString());                                                                                                      
                                                        }
                                                      }
                                                      setModalState((){
                                                        if(_days.isEmpty){
                                                          txtRepeat = "No Repeat";
                                                        }
                                                        else if(_days.length>=7){
                                                          txtRepeat = "Everyday";
                                                        } 
                                                        else if((_days.length==2)&&(_days[0]=="Sat")&&(_days[1]=="Sun")){
                                                          txtRepeat = "Every Weekends";
                                                        } 
                                                        else if((_days.length==5)&&(_days[0]=="Mon")&&(_days[1]=="Tue")&&(_days[2]=="Wed")&&(_days[3]=="Thu")&&(_days[4]=="Fri")){
                                                          txtRepeat = "Every Weekdays";
                                                        }                                                         
                                                        else{
                                                          txtRepeat = _days.toString().replaceAll('[', '').replaceAll(']', '');
                                                        }
                                                        
                                                      });
                                                      Navigator.pop(context);                                                 
                                                      },                                                 
                                                    child: Text(
                                                      'Select',
                                                      style: TextStyle(
                                                          color: txtColorLight),
                                                    ),
                                                  ))
                                            ],
                                          );
                                          });
                                        },                                    
                                      );                                 
                                  },
                            ),
                            ListTile(
                              leading:  Text(
                                      'Sound  - ',
                                      style: TextStyle(
                                          color: txtColorDark,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                              title: Text(
                                      txtSoundDisplay,
                                      style: TextStyle(
                                          color: txtColorDark,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () {                                                                   
                                  showDialog(    
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(builder: (context, setSoundState){                                      
                                            return AlertDialog(                                       
                                            content: Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: MediaQuery.of(context).size.height,
                                              child: Column(         
                                                children: [
                                                  Expanded(
                                                    child: ListView(
                                                        shrinkWrap: true,            
                                                        children: [
                                                          ListView.builder(
                                                            shrinkWrap: true,
                                                            itemCount: _alarmSoundList.length,
                                                            itemBuilder: (_, index) {
                                                              return RadioListTile(
                                                                activeColor: headerBackgroundColor,
                                                                title: Text(_alarmSoundList[index].toString()),
                                                                value: alarmSoundFiles[index],
                                                                groupValue: selectedValue,
                                                                selected: selectedValue == alarmSoundFiles[index],
                                                                onChanged: (val) async {                                                                                                                                                                                                                                                                                                                      
                                                                      await player.setAsset(ringToneBaseUrl + alarmSoundFiles[index] + '.wav');
                                                                      await player.setClip(end: Duration(seconds: 10));
                                                                      player.play();                                                                                                                                           
                                                                      setSoundState(() {
                                                                        selectedValue = val.toString();
                                                                      });
                                                                      setModalState((){                                                    
                                                                        txtSoundDisplay = _alarmSoundList[index];
                                                                      });
                                                                      print('selected:' + selectedValue.toString());                                                                      
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
                                                    color: headerBackgroundColor,
                                                    onPressed: (){                                                                   
                                                        if(selectedValue==null){
                                                          EasyLoading.showInfo('Please choose alarm sound');
                                                        }else{
                                                          setSoundState((){
                                                          txtSound = selectedValue!;
                                                          selectedValue = _alarmSoundList[0];
                                                          // txtSoundDisplay = "Sound";
                                                          });                                                   
                                                          player.stop();
                                                          Navigator.pop(context);
                                                        }                                                                                              
                                                      },                                                 
                                                    child: Text(
                                                      'Select',
                                                      style: TextStyle(
                                                          color: txtColorLight),
                                                    ),
                                                  ))
                                            ],
                                          );
                                          });
                                        },                                    
                                      );                         
                              },
                            ),
                            ListTile(
                              leading:  Text(
                                      'Label    - ',
                                      style: TextStyle(
                                          color: txtColorDark,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                title: Text(
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
                                              decoration: InputDecoration(focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: headerBackgroundColor, width: 1.0),
                                              ), hintText: "Enter here"),
                                            ),
                                            actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                                setModalState(() {
                                                if(txtInputTitle.text=="")
                                                {
                                                  title="Hello";
                                                }
                                                else
                                                {
                                                  title = txtInputTitle.text; 
                                                }                                             
                                                });
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
                              );
                              },
                            ),   
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FloatingActionButton.extended(
                                  backgroundColor: headerBackgroundColor,
                                  onPressed: () async {    
                                   
                                                                       
                                                                        

                                    if(txtRepeat=="No Repeat"){
                                      var idStr = DateFormat('ddHHmmss').format(DateTime.now());
                                      var alarmInfo = AlarmInfo(                              
                                        id: int.parse(idStr),
                                        title: title,
                                        alarmDateTime: _alarmTime,
                                        alarmOnOff: "true",
                                        repeat: txtRepeat,
                                        sound: txtSound);
                                      _alarmHelper.insertAlarm(alarmInfo);

                                      _alarmHelper.scheduleAlarm(_alarmTime!, alarmInfo);                                  
                                    }
                                    else{
                                      var idStr = DateFormat('ddHHmmss').format(DateTime.now()).toString();                                         
                                      var alarmInfo = AlarmInfo(                              
                                        id: int.parse(idStr),
                                        title: title,
                                        alarmDateTime: _alarmTime,
                                        alarmOnOff: "true",
                                        repeat: txtRepeat,
                                        sound: txtSound);

                                      for(var i = 0; i < _isChecked.length; i++)
                                      {                                    
                                        if(_isChecked[i]==true){   
                                          var idStrSched = DateFormat('ddHHmmss').format(DateTime.now())+i.toString();                                         
                                          var alarmInfoSched = AlarmInfo(                              
                                            id: int.parse(idStrSched),
                                            title: title,
                                            alarmDateTime: _alarmTime,
                                            alarmOnOff: "true",
                                            repeat: txtRepeat,
                                            sound: txtSound);                                                                                                                                
                                          var time = Time(_alarmTime!.hour,_alarmTime!.minute, _alarmTime!.second);                                                                                  
                                          _alarmHelper.scheduleAlarmRepeated(_dayDates[i],time,alarmInfoSched);                                                                                                                           
                                        }                                        
                                      }  
                                       _alarmHelper.insertAlarm(alarmInfo);                                                                      
                                    }
                                    
                                    Navigator.pop(context);                            
                                    loadAlarms();
                                    setState(() {   
                                      _alarmTimeString = DateFormat('hh:mm aa')
                                        .format(DateTime.now());  
                                      _alarmTime = DateTime.now();                            
                                      title = "Hello";
                                      txtRepeat = "No Repeat";
                                      txtSoundDisplay = "Cold";
                                      txtSound = "longcold";   
                                      for(var i = 0; i < _isChecked.length; i++)
                                      {
                                        _isChecked[i]=false;
                                      }                                                                                                    
                                    });
                                  },
                                  icon: Icon(Icons.alarm),
                                  label: Text('Add Alarm'),
                                ),
                                FloatingActionButton.extended(
                                  backgroundColor: headerBackgroundColor,
                                  onPressed: () {Navigator.pop(context);}  ,
                                  icon: Icon(Icons.cancel),
                                  label: Text('Cancel'),
                                ),
                            ],),                                    
                          ],
                        ),
                      );
                    },                          
                  );
                },
              );
            },
            child: Icon(Icons.add, size: 30),
            backgroundColor: headerBackgroundColor,               
            ),
          ),            
    );
  }
}
    
