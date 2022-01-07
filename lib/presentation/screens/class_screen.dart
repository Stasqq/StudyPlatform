import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/logic/bloc/classes_bloc/classes_bloc.dart';
import 'package:study_platform/logic/cubit/class_content_edit_cubit/class_content_cubit.dart';
import 'package:study_platform/presentation/widgets/study_platform_scaffold.dart';

import '../../constants/string_variables.dart';

class ClassScreen extends StatelessWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudyPlatformScaffold(
      title: (context.read<ClassesBloc>().state as ClassesStateLoadSuccess)
          .currentClass
          .name,
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
                        Navigator.of(context)
                            .pushNamed(kClassContentPreviewScreen);
                      },
                      child: Text('Content'),
                    ),
                  ),
                  Text('Materials'),
                  _GetClassMaterials(),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context
                            .read<ClassesBloc>()
                            .add(CurrentClassMaterialDownloadEvent(element));
                      },
                      child: Text(element),
                    ),
                  ],
                ))
            .toList(),
      );
  }
}
