import 'package:app_settings/app_settings.dart';
import 'package:bankease/core/app_routes.dart';
import 'package:bankease/features/home/presentation/manager/home_cubit.dart';
import 'package:bankease/features/home/widgets/drawer_tile.dart';
import 'package:bankease/features/profile/presentation/manager/profile_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 49.h, bottom: 15.h),
              child: SizedBox(
                height: 49.h,
                width: 49.w,
                child: const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.black38,
                  ),
                ),
              ),
            ),
            Text(
              ref.watch(profileProvider).userEntity.name,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 22.94.h,
            )
          ]),
          DrawerTile(
              iconData: Icons.list_rounded,
              text: 'Requests',
              onTap: () {
                context.read<HomeCubit>().setTab(HomeTab.requests);
              }),
          DrawerTile(
              iconData: Icons.person,
              text: 'Account',
              onTap: () {
                context.read<HomeCubit>().setTab(HomeTab.account);
              }),
          DrawerTile(
            iconData: Icons.notifications,
            text: 'Notifications',
            onTap: () {
              AppSettings.openAppSettings(type: AppSettingsType.notification);
            },
          ),
          DrawerTile(
              iconData: Icons.logout,
              text: 'Logout',
              onTap: () {
                ref.read(profileProvider.notifier).logout();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.login, (Route<dynamic> route) => false);
              }),
        ],
      ),
    );
  }
}
