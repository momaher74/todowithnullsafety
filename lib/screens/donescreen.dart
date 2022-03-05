import 'package:animation/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../methods/methods.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
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
                      var doneTasks = cubit.doneTasks[index];
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
                              text: doneTasks['title'],
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
                            MyText(text: doneTasks['body'], fontSize: 22),
                            MyHeightSizedBox(x: 18),
                            const Divider(
                              height: 3,
                              color: Colors.cyanAccent,
                            ),
                            MyHeightSizedBox(x: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.timelapse,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                MyWidthSizedBox(x: 10),
                                Text(
                                  doneTasks['date'],
                                  style: GoogleFonts.pacifico(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                MyWidthSizedBox(x: 18),
                                Text(
                                  doneTasks['time'],
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
                                    text: 'Recycle',
                                  ),
                                  function: () {
                                    cubit.updateData(
                                        status: 'new', id: doneTasks['id']);
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
                                    cubit.updateData(
                                        status: 'delete', id: doneTasks['id']);
                                  },
                                  width: 160,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: cubit.doneTasks.length,
                    shrinkWrap: true,
                  ),
                  if (state is! GetLoadingState && cubit.doneTasks.isEmpty)
                    Column(
                      children: [
                        MyHeightSizedBox(x: 200),
                        const Icon(
                          Icons.list_alt,
                          size: 150,
                          color: Colors.white,
                        ),
                        MyHeightSizedBox(x: 30),
                        MyText(
                          text: "there is no tasks , Add a task",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
