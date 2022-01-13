import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:study_platform/constants/colors.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/constants/styles.dart';
import 'package:study_platform/logic/bloc/classes_bloc/classes_bloc.dart';
import 'package:study_platform/logic/cubit/class_content_cubit/class_content_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

class ClassContentPreviewScreen extends StatelessWidget {
  const ClassContentPreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: kClassContentScreenText,
      child: BlocBuilder<ClassContentCubit, ClassContentState>(
        builder: (context, state) {
          if (state is ClassContentDataLoadingState)
            return Center(child: CircularProgressIndicator());
          else if (state is ClassContentDataLoadingSuccessState) {
            return SingleChildScrollView(
              child: GestureDetector(
                child: Column(
                  children: [
                    HtmlWidget(
                      state.htmlText,
                    ),
                    Column(
                      children: [
                        SizedBox(height: 8),
                        Divider(color: lightPrimaryColor),
                        SizedBox(height: 8),
                        Text(
                          kMaterialsText,
                          style: kNormalTextStyle,
                        ),
                      ],
                    ),
                    Column(
                      children: (context.read<ClassesBloc>().state
                              as ClassesStateLoadSuccess)
                          .currentClass
                          .materials
                          .map((element) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      context.read<ClassesBloc>().add(
                                          CurrentClassMaterialDownloadEvent(
                                              element));
                                    },
                                    child: Text(element),
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Text(kError);
          }
        },
      ),
    );
  }
}
