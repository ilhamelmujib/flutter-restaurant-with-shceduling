import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_restaurant/data/api/api_service.dart';
import 'package:flutter_restaurant/provider/database_provider.dart';
import 'package:flutter_restaurant/provider/preferences_provider.dart';
import 'package:flutter_restaurant/provider/restaurant_detail_provider.dart';
import 'package:flutter_restaurant/provider/restaurant_provider.dart';
import 'package:flutter_restaurant/provider/scheduling_provider.dart';
import 'package:flutter_restaurant/ui/detail_page.dart';
import 'package:flutter_restaurant/ui/list_page.dart';
import 'package:flutter_restaurant/ui/settings_page.dart';
import 'package:flutter_restaurant/utils/background_service.dart';
import 'package:flutter_restaurant/utils/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/navigation.dart';
import 'common/styles.dart';
import 'data/db/database_helper.dart';
import 'data/preferences/preferences_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantDetailProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Restaurant App',
            theme: ThemeData(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: primaryColor,
                    onPrimary: Colors.black,
                    secondary: secondaryColor,
                  ),
              textTheme: textTheme,
              appBarTheme: const AppBarTheme(elevation: 0),
            ),
            navigatorKey: navigatorKey,
            initialRoute: ListPage.routeName,
            routes: {
              ListPage.routeName: (context) => const ListPage(),
              DetailPage.routeName: (context) => DetailPage(
                    id: ModalRoute.of(context)?.settings.arguments as String,
                  ),
              SettingsPage.routeName: (context) => const SettingsPage()
            },
          );
        },
      ),
    );
  }
}
