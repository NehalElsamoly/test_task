import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_club/core/exports.dart';
import 'package:travel_club/core/preferences/preferences.dart';
import 'package:travel_club/injector.dart' as injector;
import 'app.dart';
import 'app_bloc_observer.dart';
import 'core/utils/restart_app_class.dart';
import 'firebase_options.dart';
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
int id = 0;
String notificationId = "0";
String notificationType = "";
bool isWithNotification = false;
///Cloud messaging step 1
FirebaseMessaging messaging = FirebaseMessaging.instance;
// handling firebase background notification
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: notificationn  ${message.notification?.title}");
}
/// flutter local notification
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  // final shorebirdCodePush = ShorebirdCodePush();
  // ShorebirdCodePush.initialize();
// Get the current patch version, or null if no patch is installed.
//   final currentPatchversion = shorebirdCodePush.currentPatchVersion();

// Check whether a patch is available to install.
//   final isUpdateAvailable = await shorebirdCodePush.isNewPatchAvailableForDownload();
//
//   if (isUpdateAvailable) {
//     // Download the patch.
//     await shorebirdCodePush.downloadUpdate();
//   }
  // final updater = ShorebirdUpdater();
  // await Shorebird.initialize();  // updater.readCurrentPatch().then((currentPatch) {
  //   print('The current patch number is: ${currentPatch?.number}');
  // });
  /// Firebase Message settings //////

  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
//// الحتة دي مهمة جداااااااا
  //// WHEN APP IS KILLED (NOT IN BACK GROUND) ///////////
  // when app recieve a message
  if (initialMessage != null) {
//  change isWithNotification to true
    isWithNotification = true;
//    set notificationType and notificationId from message
    notificationType = initialMessage.data['type'] ?? "";
    notificationId = initialMessage.data['id'] ?? "-1";
  }
// the data will be like this
/*
 {
    "message": {
        "token": "d3h7CB28T0CmD_ocRozVF9:APA91bFXLglA_9Pzn4-pKi9uh9v4uZeLXX3H2smHsIGB57r-uo61ITlwdqyqZxrtGTlKImBWBare9g1YrmtR1-GbFyiz8hroYr9eH6Xme-RPWb432IrXq7FGdPz9FMg2XQHPgSkFUeQn",
        "notification": {
            "body": "This is an FCM notification message!",
            "title": "FCM Message new"
        },
        "data": {
            "id": "2121",
            "type": "trip"
        }
    }
}
 */

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("rrrrrrrrrr");
    // if (message.data['type'] == "trip") {
    //   navigatorKey.currentState?.pushNamed(Routes.tripDetailsRoute,
    //       arguments: message.data['id'].toString());
    // } else {
    //   navigatorKey.currentState?.pushNamed(Routes.notificationScreen);
    // }
    // we can check a notification data and go to the notification screen or trip details screen or product details screen
  });

  ///Cloud messaging step 2
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // firebase notification if app is opened
  FirebaseMessaging.onMessage.listen((event) {
    print('on messageee${event.notification!.body!.toString()}');
    print('on messageee data ${event.data.toString()}');
    // show local notification
    showNotification(
        body: event.notification!.body!,
        title: event.notification!.title,
        payload: event.data.toString());
  });

//*************** local nottification settings  for android and IOS ************//

// don't forget to add the app icon image to "android\app\src\main\res\drawable\app_icon.png"
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  DarwinInitializationSettings initializationSettingsIOS =
      const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
// هنا بنقوله لما تضغط علي الاشعار حتعمل ايه
    onDidReceiveNotificationResponse: (NotificationResponse details) async {
      navigatorKey.currentState?.pushNamed(Routes.notificationScreen);
      print('dddddddddddddddddddddddd');
      print(details.payload.toString());
    },
  );

  if (Platform.isAndroid) {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }
  if (Platform.isIOS) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
  //secure stoarge

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  IOSOptions _getIOSOptions() => const IOSOptions(
      accessibility: KeychainAccessibility.first_unlock
  );

  prefs = await SharedPreferences.getInstance();
  storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  // storage = await  FlutterSecureStorage(aOptions: _getIOSOptions());;
  getToken();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await injector.setup();
  Bloc.observer = AppBlocObserver();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        // Locale('de'),
        // Locale('it'),
        // Locale('ko'),
        // Locale('ru'),
        // Locale('es'),
        ],
      path: 'assets/lang',
      saveLocale: true,
      startLocale: const Locale('ar', ''),
      fallbackLocale: const Locale('ar', ''),
      child: const MyAppWithScreenUtil(),
    ),
  );
}
class MyAppWithScreenUtil extends StatelessWidget {
  const MyAppWithScreenUtil({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        // Use MediaQuery to get the current screen size
        final mediaQuery = MediaQuery.of(context);
        final screenWidth = mediaQuery.size.width;
        final screenHeight = mediaQuery.size.height;
        return ScreenUtilInit(
          designSize: Size(screenWidth, screenHeight),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return HotRestartController(
              child: const MyApp(),
            );
          },
        );
      },
    );
  }
}

///Cloud messaging step 3
//token used for identify user in databse
getToken() async {
  String? token = await messaging.getToken();
  print("token =  $token");
  // messaging.deleteToken();
  Preferences.instance.setNotificationToken(value: token ?? '');
  return token;
}

// show local notification when app is in forground
Future<void> showNotification(
    {required String body, title, String? payload}) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          icon: 'app_icon',
          ticker: 'ticker');
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin
      .show(id++, title, body, notificationDetails, payload: payload);
}
