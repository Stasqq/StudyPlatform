import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:study_platform/constants/colors.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/constants/styles.dart';
import 'package:study_platform/logic/cubit/course_cubit/course_cubit.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class CreateCourseScreen extends StatelessWidget {
  const CreateCourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: kCreateCourseScreenText,
      child: BlocListener<CourseCubit, CourseState>(
        listener: _onCourseChange,
        child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _CourseNameInput(),
              const SizedBox(height: 8),
              _DescriptionInput(),
              const SizedBox(height: 8),
              _PublicInput(),
              const SizedBox(height: 8),
              _SubmitCreateCourseButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _onCourseChange(BuildContext context, CourseState state) {
    if (state.status.isSubmissionSuccess) {
      Navigator.of(context).pushNamed(kCoursesScreen);
    } else if (state.status.isSubmissionFailure) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(state.errorMessage ?? kCourseCreatingFailure),
          ),
        );
    }
  }
}

class _CourseNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      buildWhen: (previous, current) =>
          previous.courseName != current.courseName,
      builder: (context, state) {
        return TextField(
          onChanged: (courseName) =>
              context.read<CourseCubit>().courseNameChanged(courseName),
          decoration: InputDecoration(
            labelText: kCourseNameLabel,
            helperText: kCourseNameLabelHelper,
            errorText:
                state.courseName.invalid ? kCourseNameLabelInvalid : null,
          ),
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onChanged: (description) =>
              context.read<CourseCubit>().descriptionChanged(description),
          decoration: InputDecoration(
            labelText: kDescriptionLabel,
            helperText: kDescriptionLabelHelper,
            errorText:
                state.isDescriptionValid() ? null : kDescriptionLabelInvalid,
          ),
        );
      },
    );
  }
}

class _PublicInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      buildWhen: (previous, current) => previous.public != current.public,
      builder: (context, state) {
        return ListTile(
          title: const Text(kSetPublic),
          leading: Checkbox(
            checkColor: accentColor,
            value: state.public,
            onChanged: (bool? value) =>
                context.read<CourseCubit>().publicChanged(value!),
          ),
        );
      },
    );
  }
}

class _SubmitCreateCourseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String ownerName = context.read<UserInfoCubit>().state.userName;

    return BlocBuilder<CourseCubit, CourseState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: kButtonStyle,
                onPressed: state.status.isValidated
                    ? () => context
                        .read<CourseCubit>()
                        .createCourseFormSubmitted(ownerName)
                    : null,
                child: const Text(kSubmitText),
              );
      },
    );
  }
}
