import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info/device_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:repairservice/repository/auth_repository/authentication_repository.dart';
import 'package:repairservice/repository/user_repository/user_repository.dart';
import 'package:repairservice/simple_bloc_observer.dart';
import 'package:signalr_client/signalr_client.dart';
import 'package:workmanager/workmanager.dart';
import 'app_provider.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../../utils/service/server_hosting.dart' as Host;
import 'repository/hub_repository/notification_model.dart';

// Signal R
Map<String, String> paramters = {"userId": "0123456797"};
final serverUrl =
    Uri.http(Host.Server_hosting, "/notificationhub", paramters).toString();
final serverUrls =
    "http://repairservice.somee.com/notificationhub?userId=" + "0123456797";
HubConnection hubConnection;
NotificationModel data;
//
//this is the name given to the background fetch
const simplePeriodicTask = "simplePeriodicTask";
// flutter local notification setup
void showNotification(v, flp) async {
  var android = AndroidNotificationDetails(
      'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.high, importance: Importance.max);
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android: android, iOS: iOS);
  await flp.show(0, 'Virtual intelligent solution', '$v', platform,
      payload: 'VIS \n $v');
}

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Workmanager().initialize(callbackDispatcher,
  //     isInDebugMode:
  //         true); //to true if still in testing lev turn it to false whenever you are launching the app
  // await Workmanager().registerPeriodicTask("5", simplePeriodicTask,
  //     existingWorkPolicy: ExistingWorkPolicy.replace,
  //     frequency: Duration(minutes: 15), //when should it check the link
  //     initialDelay:
  //         Duration(seconds: 5), //duration before showing the notification
  //     constraints: Constraints(
  //       networkType: NetworkType.connected,
  //     ));
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(AppProvider(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}

void callbackDispatcher() {
  try {
    Workmanager().executeTask((task, inputData) async {
      FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
      var android = AndroidInitializationSettings('app_icon');
      var iOS = IOSInitializationSettings();
      var initSetttings = InitializationSettings(android: android, iOS: iOS);
      flp.initialize(initSetttings);
      // SignalR
      hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
      hubConnection.onclose((error) {
        print("Connect Closed");
      });
      hubConnection.on("sendToUser", (val) {
        _handNewData(val, flp);
      });
      await hubConnection
          .start()
          .then((value) => {print("Connect is OK")})
          .catchError((onError) => {print(onError)});
      print(hubConnection.state.toString());
      _showNotification("I Love U", flp);
      return Future.value(true);
    });
  } on Exception catch (e) {
    print(e);
  }
}

void _showNotification(String v, flp) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'your channel id', 'your channel name', 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flp.show(
      0, 'Thông báo', 'đã thông báo cho em rồi', platformChannelSpecifics,
      payload: 'item x');
}

_handNewData(List<Object> args, flp) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'your channel id', 'your channel name', 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flp.show(
      0, 'Thông báo', 'đã thông báo cho em rồi', platformChannelSpecifics,
      payload: 'item x');
}
