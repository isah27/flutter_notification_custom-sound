import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
dynamic noti;
onDidReceiveNotificationResponse(NotificationResponse response){
log("Notification:${response.payload}");

// noti="response";

}
 void onDidReceiveLocalNotification(
    int? id, String? title, String? body, String? payload) async {
      // noti="response";
      
      log("Notification received");
  // display a dialog with the notification details, tap ok to go to another page
   
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
final pref=await SharedPreferences.getInstance();
 noti=pref.getBool("noti");
const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    );
await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  Provider.debugCheckInvalidValueType=null;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
   Widget build(BuildContext context)  {
    return  NotiApp();
  }
}

class NotiApp extends StatelessWidget {
    NotiApp({
    super. key
  });

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const MyHomePage(title:"Notification Demo"),
    );
  
 }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

 

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void soundNoti() async{
        // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

    await Future.delayed(Duration(seconds: 5));
    flutterLocalNotificationsPlugin.show(8, "hello", "body", NotificationDetails(
      android: AndroidNotificationDetails("2", "channelName",fullScreenIntent: true,importance: Importance.max,priority: Priority.max,sound: RawResourceAndroidNotificationSound("noti"))
    ));
    // context.read<PageProvider>().changePage("not");

  }

 

  @override
  Widget build(BuildContext context) {
 
 
   return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: 
           Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Text(
              'Notification Demo',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),),
      
        
      floatingActionButton: FloatingActionButton(
        onPressed: soundNoti,
        tooltip: 'Increment',
        child: const Icon(Icons.notification_add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

  