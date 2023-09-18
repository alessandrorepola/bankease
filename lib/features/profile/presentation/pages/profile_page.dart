import 'package:flutter/material.dart';
import 'package:bankease/features/profile/presentation/manager/profile_manager.dart';
import 'package:bankease/features/profile/presentation/widgets/profile_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(profileProvider);
    // final notifier = ref.read(profileProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 80.5.h),
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
        SizedBox(height: 40.5.h),
        Text(state.userEntity.name),
        Padding(
          padding: EdgeInsets.only(top: 3.h, bottom: 57.h),
          child: Text(state.userEntity.email),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ProfileButton(onPressed: () {}, text: 'Edit', iconData: Icons.edit),
            ProfileButton(
                onPressed: () {}, text: 'Settings', iconData: Icons.settings),
          ],
        )
      ],
    );
  }
}
