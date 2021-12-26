import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/todo_app/cubit/cubit.dart';
import 'package:movie_app/layout/todo_app/cubit/states.dart';
import 'package:movie_app/shared/components/components.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){

        var tasks = AppCubit.get(context).newTasks;
        return taskBuilder(tasks: tasks, context: context);

      },
    );
  }
}
