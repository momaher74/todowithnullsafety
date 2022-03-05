import 'package:animation/screens/deleteed.dart';
import 'package:animation/screens/donescreen.dart';
import 'package:animation/screens/tasksscreen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  List<String> title = [
    'tasks',
    'done',
    'deleted',
  ];

  List newTasks = [];
  List deletedTasks = [];
  List doneTasks = [];
  List<Widget> screens = const [
    TasksScreen(),
    DoneScreen(),
    DeletedScreen(),
  ];
  int currentIdx = 0;

  changeIdx(int index) {
    currentIdx = index;
    emit(ChangeNavSuccessState());
  }

  Database? database;

  void createDB() async {
    await openDatabase('tasks.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'create table tasks (id integer primary key , title text , body text , date text , time text , status text )')
          .then((value) {
        emit(OnCreateSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(OnCreateSuccessState());
      });
    }, onOpen: (database) {})
        .then((value) {
      database = value;
      getDataFromDataBase();
      emit(OnOpenSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(OnOpenErrorState());
    });
  }

  void getDataFromDataBase() {
    newTasks = [];
    doneTasks = [];
    deletedTasks = [];
    emit(GetLoadingState());
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        }
        if (element['status'] == 'done') {
          doneTasks.add(element);
        }
        if (element['status'] == 'delete') {
          deletedTasks.add(element);
        }
      });
      print(newTasks.length);
      print(doneTasks.length);
      print(deletedTasks.length);
      emit(GetSuccessState());
    }).catchError((error) {
      print(error);
      emit(GetErrorState());
    });
  }

  void insertToDataBase({
    required String title,
    required String body,
    required String date,
    required String time,
  }) async {
    emit(InsertLoadingState());
    await database!.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks(title,body, date, time, status) VALUES( "$title" , "$body" , "$date" , "$time" , "new" )')
          .then((value) {
        getDataFromDataBase();
        emit(InsertSuccessState());
      }).catchError((error) {
        print('err' + error);
        emit(InsertErrorState());
      });
    });
  }

  void updateData({
    required String status,
    required int id,
  }) {
    database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      getDataFromDataBase();
      emit(UpdateSuccessState());
    }).catchError((error) {
      emit(UpdateErrorState());
    });
  }

  void deleteData({
    required int id,
  }) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDataBase();
      emit(DeleteSuccessState());
    }).catchError((error) {
      emit(DeleteErrorState());
    });
  }
}
