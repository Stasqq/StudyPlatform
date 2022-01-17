import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/constants/styles.dart';
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
                    if (userInfo.photoPath!.isEmpty)
                      return Image.asset(
                        kDefaultAvatarImage,
                        height: 300,
                        width: 300,
                      );
                    else if (state is PhotoUriNotGenerated) {
                      context
                          .read<PhotoUriCubit>()
                          .generateUri(userInfo.photoPath!);
                      return CircularProgressIndicator();
                    } else if (state is PhotoUriGenerated)
                      return Image.network(
                        state.uri,
                        height: 300,
                        width: 300,
                      );
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
                        child: Text(kChangePhoto),
                        style: kButtonStyle,
                      )
                    : SizedBox(),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            kFirstname,
                            textAlign: TextAlign.right,
                            style: kNormalTextStyle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: Text(
                            userInfo.firstName,
                            style: kBigTextStyle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            kSurname,
                            textAlign: TextAlign.right,
                            style: kNormalTextStyle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: Text(
                            userInfo.surname,
                            style: kBigTextStyle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            kEmail,
                            textAlign: TextAlign.right,
                            style: kNormalTextStyle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: Text(
                            userInfo.email!,
                            style: kBigTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
