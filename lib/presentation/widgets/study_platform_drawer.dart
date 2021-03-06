import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:study_platform/presentation/screens/general/profile_screen.dart';

class StudyPlatformDrawer extends StatelessWidget {
  const StudyPlatformDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                kAppTitle,
                style: TextStyle(
                  fontSize: 48,
                ),
              ),
            ),
          ),
          _DrawerItem(
            iconData: Icons.format_list_bulleted,
            title: kCoursesScreenText,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(kCoursesScreen);
            },
          ),
          _DrawerItem(
            iconData: Icons.add,
            title: kCreateCourseScreenText,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(kCreateCourseScreen);
            },
          ),
          _DrawerItem(
            iconData: Icons.perm_identity,
            title: kProfileScreenText,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                          currentUser: true,
                        )),
              );
            },
          ),
          _DrawerItem(
            iconData: Icons.logout,
            title: kLogoutText,
            onTap: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
              Navigator.of(context).pushNamed(kWelcomeScreen);
            },
          ),
          Visibility(
            visible: !kIsWeb,
            child: _DrawerItem(
              iconData: Icons.close,
              title: kCloseAppText,
              onTap: () {
                Platform.isAndroid ? SystemNavigator.pop() : exit(0);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// nicely done
class _DrawerItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback? onTap;

  const _DrawerItem({
    Key? key,
    required this.iconData,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Center(
        child: ListTile(
          leading: Icon(
            iconData,
            size: 32,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
