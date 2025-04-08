import 'package:first_pro/shared/components/components.dart';
import 'package:first_pro/shared/cubit/cubit.dart';
import 'package:first_pro/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archivedTasks;
        return tasks.length > 0
            ? ListView.separated(
              itemBuilder:
                  (context, index) => buildTaskItem(tasks[index], context),
              separatorBuilder:
                  (context, index) => Padding(
                    padding: const EdgeInsetsDirectional.only(start: 20.0),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),
              itemCount: tasks.length,
            )
            : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu, size: 100.0, color: Colors.grey),
                  Text(
                    'No Tasks Yet, Please Add Some Tasks',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
      },
    );
  }
}
