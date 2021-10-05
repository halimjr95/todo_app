import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget
{

  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppSates>(
        listener: (BuildContext context, state) {
          if(state is AppInsertToDatabaseState)
            {
              Navigator.pop(context);
            }
        },
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text(
                  '${cubit.title[cubit.currentIndex]}'
              ),
            ),
            body: state is !AppGetDatabaseLoadingState ? cubit.screens[cubit.currentIndex] : Center(child: CircularProgressIndicator()),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                if(cubit.isButtonSheetShown) {
                  if(formkey.currentState!.validate()){
                    cubit.insertToDatabase(
                        title: titleController.text,
                        date: dateController.text,
                        time: timeController.text
                    );
                    // insertToDatabase(
                    //   title: titleController.text,
                    //   time: timeController.text,
                    //   date: dateController.text,
                    // ).then((value){
                    //   Navigator.pop(context);
                    //   isButtonSheetShown = false;
                    //   // setState(() {
                    //   //   fabIcon = Icons.edit;
                    //   // });
                    // });
                  }
                } else {
                  scaffoldkey.currentState!.showBottomSheet(
                        (context) => Container(
                        color: Colors.grey[100],
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DefaultFormFied(
                                  type: TextInputType.text,
                                  controller: titleController,
                                  validate: (value) {
                                    if(value!.isEmpty){
                                      return "Title can not be empty";
                                    }
                                    return null;
                                  },
                                  label: 'Task Title',
                                  prefix: Icons.title,
                                ),
                                SizedBox(height: 10,),
                                DefaultFormFied(
                                  type: TextInputType.datetime,
                                  controller: timeController,
                                  validate: (value) {
                                    if(value!.isEmpty){
                                      return "Time can not be empty";
                                    }
                                    return null;
                                  },
                                  onTap: (){
                                    showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now()
                                    ).then(
                                            (value) => {
                                          timeController.text = value!.format(context).toString()
                                        }
                                    );
                                  },
                                  label: 'Task Time',
                                  prefix: Icons.watch_later_outlined,
                                ),
                                SizedBox(height: 10,),
                                DefaultFormFied(
                                  type: TextInputType.datetime,
                                  controller: dateController,
                                  validate: (value) {
                                    if(value!.isEmpty){
                                      return "Date can not be empty";
                                    }
                                    return null;
                                  },
                                  onTap: (){
                                    showDatePicker
                                      (
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2090-01-01'),
                                    ).then(
                                            (value) =>
                                        {
                                          dateController.text = DateFormat.yMMMd().format(value!)
                                        }
                                    );
                                  },
                                  label: 'Task Date',
                                  prefix: Icons.calendar_today_outlined,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  ).closed.then((value) =>
                  {
                    cubit.changeButtomSheetState(
                        isShow: false,
                        icon: Icons.edit
                    )
                  });
                  cubit.changeButtomSheetState(
                      isShow: true,
                      icon: Icons.add
                  );
                }
              },
              child: Icon(
                  cubit.fabIcon
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: AppCubit.get(context).currentIndex,
              onTap: (index){
                AppCubit.get(context).changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                      Icons.menu
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                      Icons.check_circle_outline
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                      Icons.archive_outlined
                  ),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }


}
