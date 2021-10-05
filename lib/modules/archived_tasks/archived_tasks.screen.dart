import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class ArchivedTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppSates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, state) {
        var tasks = AppCubit.get(context).archiveTasks;
        return tasks.length > 0 ? ListView.separated(
          itemBuilder: (context, index) => DefaultTaskTemp(context, tasks[index]),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 25.0,
                end: 25.0
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color:  Colors.grey[300],
            ),
          ),
          itemCount: tasks.length,
        ) : Column
          (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.menu,
                size: 80.0,
                color: Colors.grey,
              ),
            ),
            Text(
              'No Tasks Yet',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            )
          ],
        );
      },
    );
  }
}
