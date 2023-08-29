import 'package:flutter/material.dart';
import 'package:bankease/features/profile/presentation/manager/profile_manager.dart';
import 'package:bankease/features/profile/presentation/widgets/profile_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(profileProvider);
    // final notifier = ref.read(profileProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                  // top: 150,
                  bottom: -50,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 133.h,
                        width: 133.w,
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.person,
                            color: Colors.black38,
                          ),
                        ),
                      ))),
            ]),
        SizedBox(height: 80.5.h),
        const Text('Username'),
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
