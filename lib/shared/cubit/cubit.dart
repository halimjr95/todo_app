import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/archived_tasks/archived_tasks.screen.dart';
import 'package:todo/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo/shared/cubit/states.dart';


class AppCubit extends Cubit<AppSates>
{
  AppCubit() : super(AppIntialState());

  static AppCubit get(context) => BlocProvider.of(context);

  var currentIndex = 0;

  late Database database;

  var newTasks = [];
  var doneTasks = [];
  var archiveTasks = [];


  bool isButtonSheetShown = false;
  IconData fabIcon = Icons.edit;


  var title = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks'
  ];

  var screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];

  void changeIndex(index)
  {
    currentIndex = index;
    emit(AppChangeBotNavState());
  }

  void changeButtomSheetState({
    required bool isShow,
    required IconData icon,
  })
  {
    isButtonSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBotSheetState());
  }


  void createDatabase() async
  {
     await openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version) {
          print('database created');
          database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)'
          ).then((value) => {
            print('table created')
          }).catchError((error)=> {
            print('error found ${error.toString()}')
          });
        },
        onOpen: (database) {
          print('database opened');
          getDataFromDatabase(database);
        }
    ).then((value){
       database = value;
       emit(AppCreateDatabaseState());
     });
  }

  
  void insertToDatabase({
    @required title,
    @required date,
    @required time,
  })  => database.transaction((txn)
   async {
    txn.rawInsert(
        'INSERT INTO tasks(title, date, time, status) VALUES("${title}", "${date}", "${time}", "new")'
    ).then((value)
    {
      print("${value} successssss");
      emit(AppInsertToDatabaseState());
      getDataFromDatabase(database);
    }).catchError((error)
    {
      print('${error.toString()} erooooooor');
    });
  });


  void updateDatebase({
    required int id,
    required String status,
  })
  {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value)
    {
      emit(AppUpdateDatabaseState());
      getDataFromDatabase(database);
    });
  }

  void deleteDatebase({
    required int id,
  })
  {
    database.rawUpdate(
      'DELETE FROM tasks WHERE id = ?', [id],
    ).then((value)
    {
      emit(AppDeleteDatabaseState());
      getDataFromDatabase(database);
    });
  }



  void getDataFromDatabase(database)
  {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value)
    {
      print(value);
      value.forEach((element)
      {
        print(element['status']);
        if(element['status']=='new')
          newTasks.add(element);
        else if(element['status']=='done')
          doneTasks.add(element);
        else if(element['status']=='archive')
          archiveTasks.add(element);
      });
      emit(AppGetFromDatabaseState());
    });
  }

}