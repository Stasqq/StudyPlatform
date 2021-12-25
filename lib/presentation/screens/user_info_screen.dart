import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:study_platform/constants/colors.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: kUserInfoScreenText,
      child: BlocListener<UserInfoCubit, UserInfoState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            context.read<UserInfoCubit>().readUserInfo();
            Navigator.of(context).pushNamed(kHomeScreen);
          } else if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? 'User Info Saving Failure')),
              );
          }
        },
        child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _FirstNameInput(),
              const SizedBox(height: 8),
              _SurnameInput(),
              const SizedBox(height: 8),
              _SaveUserInfoButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return TextField(
          key: const Key('usrInfoForm_firstNameInput_textField'),
          onChanged: (firstName) =>
              context.read<UserInfoCubit>().firstNameChanged(firstName),
          decoration: InputDecoration(
            labelText: 'First Name',
            helperText: '',
            errorText: state.surname.invalid ? 'invalid firstName' : null,
          ),
        );
      },
    );
  }
}

class _SurnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      buildWhen: (previous, current) => previous.surname != current.surname,
      builder: (context, state) {
        return TextField(
          key: const Key('usrInfoForm_surnameInput_textField'),
          onChanged: (surname) => context.read<UserInfoCubit>().surnameChanged(surname),
          decoration: InputDecoration(
            labelText: 'Surname',
            helperText: '',
            errorText: state.surname.invalid ? 'invalid surname' : null,
          ),
        );
      },
    );
  }
}

class _SaveUserInfoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('userInfoForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: kButtonColor,
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<UserInfoCubit>().userInfoFormSubmitted()
                    : null,
                child: const Text(kSubmitText),
              );
      },
    );
  }
}
