import 'package:watch_me/screens/camera.dart';
import 'package:watch_me/screens/home.dart';
import 'package:watch_me/screens/login/forgot_password.dart';
import 'package:watch_me/screens/login/login.dart';
import 'package:watch_me/screens/login/reset_password.dart';
import 'package:watch_me/screens/notification.dart';
import 'package:watch_me/screens/profile/profile_main.dart';
import 'package:watch_me/screens/profile/watcher.dart';
import 'package:watch_me/screens/profile/watching.dart';
import 'package:watch_me/screens/registration/address.dart';
import 'package:watch_me/screens/registration/cover_pic.dart';
import 'package:watch_me/screens/registration/personal_info.dart';
import 'package:watch_me/screens/registration/profile_pic.dart';
import 'package:watch_me/screens/registration/register_user.dart';
import 'package:watch_me/screens/search.dart';
import 'package:watch_me/screens/setting/address_setting.dart';
import 'package:watch_me/screens/setting/cover_setting.dart';
import 'package:watch_me/screens/setting/password_setting.dart';
import 'package:watch_me/screens/setting/personal_setting.dart';
import 'package:watch_me/screens/setting/profile_setting.dart';
import 'package:watch_me/screens/setting/setting_main.dart';
import 'package:watch_me/screens/setting/user_setting.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api/http/http_user.dart';
import 'api/token.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
    null, // icon for your app notification
    [
      NotificationChannel(
        channelKey: 'key1',
        channelName: 'WatchMe',
        channelDescription: "You have got notification from WatchMe.",
        defaultColor: Colors.deepPurpleAccent[700],
        ledColor: Colors.white,
        playSound: true,
        enableLights: true,
        importance: NotificationImportance.High,
        enableVibration: true,
      )
    ],
  );

  Token().getToken().then((value) {
    if (value.isNotEmpty) {
      Token().setToken(value);
      HttpConnectUser.token = value;
      runApp(ProviderScope(
          child: WatchMe(
        initialPage: "/home",
      )));
    } else {
      runApp(ProviderScope(
          child: WatchMe(
        initialPage: "/login",
      )));
    }
  });
}

class WatchMe extends StatefulWidget {
  final String? initialPage;
  const WatchMe({Key? key, @required this.initialPage}) : super(key: key);

  @override
  _WatchMeState createState() => _WatchMeState();
}

class _WatchMeState extends State<WatchMe> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Laila-Medium",
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: widget.initialPage,
      routes: {
        '/login': (context) => LoginUser(),
        '/register-user': (context) => RegisterUser(),
        '/add-profile': (context) => AddProfilePicture(),
        '/add-cover': (context) => AddCoverPicture(),
        '/add-personal-information': (context) => PersonalInformation(),
        '/add-address': (context) => Address(),
        '/forgot-password': (context) => ForgotPassword(),
        '/reset-password': (context) => ResetPassword(),
        '/home': (context) => Home(),
        '/search': (context) => Search(),
        '/camera': (context) => Camera(),
        '/notification': (context) => NotificationUnseen(),
        '/profile': (context) => ProfileMain(),
        '/watchers': (context) => Watcher(),
        '/watching': (context) => Watching(),
        '/setting': (context) => Setting(),
        '/profile-setting': (context) => ProfileSetting(),
        '/cover-setting': (context) => CoverSetting(),
        '/password-setting': (context) => PasswordSetting(),
        '/user-setting': (context) => UserSetting(),
        '/personal-setting': (context) => PersonalSetting(),
        '/address-setting': (context) => AddressSetting(),
      },
      title: "WatchMe Social Media App",
    );
  }
}
