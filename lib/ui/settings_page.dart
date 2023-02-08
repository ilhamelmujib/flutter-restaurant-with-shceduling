import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/common/navigation.dart';
import 'package:provider/provider.dart';

import '../provider/preferences_provider.dart';
import '../provider/scheduling_provider.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/platform_widget.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';
  static const String settingsTitle = 'Settings';

  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Recommendation Restaurants'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isDailyNotificationActive,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduled.scheduledNews(value);
                          provider.enableDailyNotification(value);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigation.back();
        }, icon: const Icon(Icons.arrow_back_ios, color: Colors.black,)),
        title: const Text(settingsTitle),
      ),
      body: _buildList(context),
    );
  }
}
