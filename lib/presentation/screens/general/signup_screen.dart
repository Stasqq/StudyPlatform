import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:study_platform/constants/colors.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/constants/styles.dart';
import 'package:study_platform/logic/cubit/signup_cubit/sign_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: kSignupScreenText,
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            Navigator.of(context).pushNamed(kUserInfoScreen);
          } else if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? kSignUpFailure),
                ),
              );
          }
        },
        child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: kLogoTag,
                child: Image.asset(
                  kEducationImage,
                  color: darkPrimaryColor,
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 16),
              _EmailInput(),
              const SizedBox(height: 8),
              _PasswordInput(),
              const SizedBox(height: 8),
              _ConfirmPasswordInput(),
              const SizedBox(height: 8),
              _SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: kTextFieldDecoration.copyWith(
            labelText: kEmailLabel,
            helperText: kEmailLabelHelper,
            errorText: state.email.invalid ? kEmailLabelInvalid : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
            onChanged: (password) =>
                context.read<SignUpCubit>().passwordChanged(password),
            obscureText: true,
            decoration: kTextFieldDecoration.copyWith(
              labelText: kPasswordLabel,
              helperText: kPasswordLabelHelper,
              errorText: state.password.invalid ? kPasswordLabelInvalid : null,
            ));
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          onChanged: (confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: kTextFieldDecoration.copyWith(
            labelText: kConfirmPasswordLabel,
            helperText: kConfirmPasswordLabelHelper,
            errorText: state.confirmedPassword.invalid
                ? kConfirmPasswordLabelInvalid
                : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: kButtonStyle,
                onPressed: state.status.isValidated
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
                child: const Text(kSignupScreenText),
              );
      },
    );
  }
}
