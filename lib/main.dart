import 'package:animation/cubit/app_cubit.dart';
import 'package:animation/methods/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'cubit/observ.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (BuildContext context) => AppCubit()..createDB(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: Home(),
          );
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  var titleController = TextEditingController();

  var bodyController = TextEditingController();

  var dateController = TextEditingController();

  var timeController = TextEditingController();


  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black87,
          appBar: AppBar(
            title: Text(
              AppCubit.get(context).title[AppCubit.get(context).currentIdx],
              style: GoogleFonts.share(
                fontSize: 30
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.black87,
          ),
          body: AppCubit.get(context).screens[AppCubit.get(context).currentIdx],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black87,
            selectedItemColor: Colors.white,
            selectedIconTheme:
                const IconThemeData(color: Colors.deepOrangeAccent),
            unselectedIconTheme: const IconThemeData(color: Colors.white),
            onTap: (index) {
              AppCubit.get(context).changeIdx(index);
            },
            currentIndex: AppCubit.get(context).currentIdx,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.task,
                    size: 28,
                  ),
                  label: 'tasks'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_rounded,
                    size: 28,
                  ),
                  label: 'done'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.delete,
                    size: 28,
                  ),
                  label: 'deleted'),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.bottomSheet(
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: myPadding(8),
                      child: Column(
                        children: [
                          MyHeightSizedBox(x: 12),
                          MyText(text: 'Add task ', fontSize: 25),
                          MyHeightSizedBox(x: 12),
                          TextFormField(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            controller: titleController,
                            decoration: const InputDecoration(
                              labelText: 'task title',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              icon: Icon(Icons.title, color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          MyHeightSizedBox(x: 12),
                          TextFormField(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              controller: bodyController,
                              decoration: const InputDecoration(
                                labelText: 'task body',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                icon: Icon(
                                  Icons.task,
                                  color: Colors.white,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                              )),
                          MyHeightSizedBox(x: 12),
                          TextFormField(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              onTap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  setState(() {
                                    DateTime now = DateTime.now();
                                    String formattedDate = DateFormat('kk:mm').format(now);
                                    timeController.text =
                                        formattedDate.toString();
                                  });
                                });
                              },
                              controller: timeController,
                              decoration: const InputDecoration(
                                labelText: 'task time',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                icon: Icon(
                                  Icons.timelapse,
                                  color: Colors.white,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                              )),
                          MyHeightSizedBox(x: 12),
                          TextFormField(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2025),
                                ).then((value) {
                                  setState(() {
                                    DateTime now = DateTime.now();
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                                    dateController.text =
                                        formattedDate.toString();
                                  });
                                });
                              },
                              controller: dateController,
                              decoration: const InputDecoration(
                                labelText: 'task date',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                              )),
                          MyHeightSizedBox(x: 20),
                          MyElevetedButton(
                            color: Colors.white,
                            widget: const Text(
                              'Add task ',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            function: () {
                              AppCubit.get(context).insertToDataBase(
                                title: titleController.text,
                                body: bodyController.text,
                                date: dateController.text,
                                time: timeController.text,
                              );
                            },

                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
