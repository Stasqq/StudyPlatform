import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:study_platform/logic/cubit/class_content_edit_cubit/class_content_cubit.dart';

import '../widgets/study_platform_scaffold.dart';

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
              title: 'Context editor',
              appBarActions: [
                ElevatedButton(
                  onPressed: () async {
                    context
                        .read<ClassContentCubit>()
                        .saveContent(htmlText: await controller.getText());
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.save),
                )
              ],
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  controller.toggleCodeView();
                },
                child: Text(r'<\>',
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
                      otherOptions: OtherOptions(height: 1000),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Text('Error');
        }
      },
    );
  }
}
