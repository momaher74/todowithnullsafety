import 'package:animation/cubit/app_cubit.dart';
import 'package:animation/methods/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              MyHeightSizedBox(x: 20),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var newItem = cubit.newTasks[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    width: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: newItem['title'],
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        MyHeightSizedBox(x: 3),
                        const Divider(
                          height: 4,
                          color: Colors.white,
                        ),
                        MyHeightSizedBox(x: 6),
                        MyText(text: newItem['body'], fontSize: 22),
                        MyHeightSizedBox(x: 18),
                        const Divider(height: 3, color: Colors.cyanAccent,),
                        MyHeightSizedBox(x: 6),
                        Row(
                          children: [
                            const Icon(Icons.timelapse , size: 25, color: Colors.white,) ,
                            MyWidthSizedBox(x: 10),
                            Text(
                              newItem['date'],
                              style: GoogleFonts.pacifico(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            MyWidthSizedBox(x: 18),
                            Text(
                              newItem['time'],
                              style: GoogleFonts.pacifico(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        MyHeightSizedBox(x: 20),
                        Row(
                          children: [
                            MyElevetedButton(
                              color: Colors.green,
                              widget: MyText(
                                fontSize: 22,
                                text: 'done',
                              ),
                              function: () {
                                cubit.updateData(status: 'done', id: newItem['id']);
                              },
                              width: 160,
                            ),
                            MyWidthSizedBox(x: 15),
                            MyElevetedButton(
                              color: Colors.redAccent,
                              widget: MyText(
                                fontSize: 22,
                                text: 'delete',
                              ),
                              function: () {
                                cubit.updateData(status: 'delete', id: newItem['id']);
                              },
                              width: 160,
                            ),
                          ],
                        ) ,
                      ],
                    ),
                  );
                },
                itemCount: cubit.newTasks.length,
                shrinkWrap: true,
              ),
              if(state is ! GetLoadingState && cubit.newTasks.isEmpty )
                Column(
                  children: [
                    MyHeightSizedBox(x: 200) ,
                    const Icon(Icons.list_alt  ,size: 120,color: Colors.white,) ,
                    MyHeightSizedBox(x: 22) ,
                    MyText(text: "there is no tasks , Add a task", fontSize: 22 , fontWeight: FontWeight.bold,),
                  ],
                )
            ],
          ),
        );
      },
    );
  }
}
