import 'package:bankease/features/home/widgets/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:bankease/features/profile/presentation/manager/profile_manager.dart';
import 'package:bankease/features/profile/presentation/widgets/profile_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(profileProvider);

    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100.5.h),
          Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 120.h,
                width: 120.w,
                child: const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    size: 50,
                    Icons.person,
                    color: Colors.black38,
                  ),
                ),
              )),
          SizedBox(height: 50.h),
          Text(
            state.userEntity.name,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h, bottom: 60.h),
            child: Text(
              state.userEntity.email,
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ProfileButton(
                  onPressed: () {}, text: 'Edit', iconData: Icons.edit),
              ProfileButton(
                  onPressed: () {}, text: 'Settings', iconData: Icons.settings),
            ],
          )
        ],
      ),
    );
  }
}
