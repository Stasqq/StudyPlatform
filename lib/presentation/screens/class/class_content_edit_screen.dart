import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/constants/styles.dart';
import 'package:study_platform/logic/cubit/class_content_cubit/class_content_cubit.dart';

import '../../widgets/study_platform_scaffold.dart';

class ClassContentEditScreen extends StatefulWidget {
  ClassContentEditScreen({Key? key}) : super(key: key);

  @override
  _ClassContentEditScreenState createState() => _ClassContentEditScreenState();
}

class _ClassContentEditScreenState extends State<ClassContentEditScreen> {
  final HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassContentCubit, ClassContentState>(
      builder: (context, state) {
        if (state is ClassContentDataLoadingState)
          return Center(child: CircularProgressIndicator());
        else if (state is ClassContentDataLoadingSuccessState) {
          return GestureDetector(
            onTap: () {
              if (!kIsWeb) {
                controller.clearFocus();
              }
            },
            child: StudyPlatformScaffold(
              title: kClassContentEditorScreenText,
              appBarActions: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (state.isTextValid) {
                          context.read<ClassContentCubit>().saveContent(
                              htmlText: await controller.getText());
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(kClassContentFileIsToBig),
                                duration: Duration(seconds: 5),
                              ),
                            );
                        }
                      },
                      child: Icon(Icons.save),
                      style: kAppBarButtonStyle,
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ],
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  controller.toggleCodeView();
                },
                child: Text(kEditorTextConvert,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HtmlEditor(
                      controller: controller,
                      htmlEditorOptions: HtmlEditorOptions(
                        shouldEnsureVisible: true,
                        initialText: state.htmlText,
                      ),
                      otherOptions: OtherOptions(height: 500),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Text(kError);
        }
      },
    );
  }
}
