import 'package:flutter/material.dart';

import '../../features/settings/view/settings_screen.dart';
import '../constants/app_assets.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leading: Image.asset(AppAssets.appBarLeadingIcon, width: 24, height: 24),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SettingsScreen()),
            );
          },
          icon: Image.asset(AppAssets.appBarActionIcon),
        ),
      ],
    );
  }
}
