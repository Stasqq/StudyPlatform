import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:study_platform/logic/bloc/classes_bloc/classes_bloc.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

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
                        //TODO: edycja tekstu lekcji
                      },
                      child: Text('Content'),
                    ),
                  ),
                  Text('Materials'),
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
          )),
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
      child: Text('Delete'),
      onPressed: () => showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete this class?'),
            actions: [
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  context.read<ClassesBloc>().add(CurrentClassDeleteEvent());
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('No'),
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
