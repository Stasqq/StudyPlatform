import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/logic/bloc/classes_bloc/classes_bloc.dart';
import 'package:study_platform/logic/cubit/class_content_edit_cubit/class_content_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

import '../../../constants/string_variables.dart';

class ClassEditScreen extends StatelessWidget {
  const ClassEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: (context.read<ClassesBloc>().state as ClassesStateLoadSuccess)
          .currentClass
          .name,
      appBarActions: [
        _DeleteClassDialogButton(),
      ],
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: BlocBuilder<ClassesBloc, ClassesState>(
          builder: (context, state) {
            return Column(
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<ClassContentCubit>()
                          .loadClass(context.read<ClassesBloc>());
                      Navigator.of(context).pushNamed(kClassContentEditScreen);
                    },
                    child: Text(kContent),
                  ),
                ),
                Text(kMaterialsText),
                _GetClassMaterials(),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<ClassesBloc>()
                        .add(CurrentClassMaterialAddEvent());
                  },
                  child: Icon(Icons.add),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class _GetClassMaterials extends StatelessWidget {
  const _GetClassMaterials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.read<ClassesBloc>().state;
    if (state is ClassesStateActionLoading)
      return CircularProgressIndicator();
    else
      return Column(
        children: (state as ClassesStateLoadSuccess)
            .currentClass
            .materials
            .map((element) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(element),
                    SizedBox(width: 8),
                    ElevatedButton(
                        onPressed: () {
                          context.read<ClassesBloc>().add(
                              CurrentClassMaterialDeleteEvent(
                                  fileName: element));
                        },
                        child: Icon(Icons.delete)),
                  ],
                ))
            .toList(),
      );
  }
}

class _DeleteClassDialogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(kDelete),
      onPressed: () => showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(kDeleteClass),
            actions: [
              TextButton(
                child: Text(kYes),
                onPressed: () {
                  context.read<ClassesBloc>().add(CurrentClassDeleteEvent());
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(kNo),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
