import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/data/models/user/user_info.dart';
import 'package:study_platform/logic/cubit/other_user_info_cubit/other_user_info_cubit.dart';
import 'package:study_platform/logic/cubit/photo_uri_cubit/photo_uri_cubit.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.currentUser}) : super(key: key);

  final bool currentUser;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserInfo userInfo;

  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: kProfileScreenText,
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: BlocBuilder<OtherUserInfoCubit, OtherUserInfoState>(
          builder: (context, state) {
            if (!widget.currentUser && state is OtherUserInfoLoadingState)
              return CircularProgressIndicator();
            else if (!widget.currentUser &&
                state is OtherUserInfoLoadingSuccessState)
              userInfo = state.otherUserInfo;
            else
              userInfo = context.read<UserInfoCubit>().getUserInfoObject();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BlocBuilder<PhotoUriCubit, PhotoUriState>(
                  builder: (BuildContext context, state) {
                    if (userInfo.photoURL! == '')
                      return Image.asset('images/default_avatar.png');
                    else if (state is PhotoUriNotGenerated) {
                      context
                          .read<PhotoUriCubit>()
                          .generateUri(userInfo.photoURL!);
                      return CircularProgressIndicator();
                    } else if (state is PhotoUriGenerated)
                      return Image.network(state.uri);
                    else
                      return SizedBox();
                  },
                ),
                (widget.currentUser)
                    ? ElevatedButton(
                        onPressed: () {
                          context.read<PhotoUriCubit>().uploadPhoto(userInfo);
                          context.read<UserInfoCubit>().readUserInfo();
                        },
                        child: Text('Change Photo'),
                      )
                    : SizedBox(),
                Text(userInfo.email!),
                const SizedBox(height: 4),
                Text(userInfo.firstName),
                const SizedBox(height: 4),
                Text(userInfo.surname),
              ],
            );
          },
        ),
      ),
    );
  }
}
