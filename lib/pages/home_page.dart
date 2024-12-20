import 'package:counter_provider/providers/timer_provider.dart';
import 'package:counter_provider/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double sWidth = MediaQuery.of(context).size.width;
    final double sHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Column(
        children: [
          //appname
          Center(
            child: Text(
              "StopWatch",
              style: TextStyle(
                fontSize: sWidth * .07,
                color: Colors.grey.shade300,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //divider
          Divider(),

          SizedBox(
            height: 40,
          ),

          //counter setting

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //timer
                Consumer<TimerProvider>(
                  builder: (context, value, child) {
                    return Text(
                      "${value.hour} : ${value.minute} : ${value.second} : ${value.mSecond}",
                      style: TextStyle(
                        fontSize: sWidth * .1,
                        color: Colors.grey.shade300,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),

                SizedBox(
                  height: 20,
                ),

                //divider b/w timer and laps
                context.watch<TimerProvider>().laps.isNotEmpty
                    ? Text(
                        "Laps",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Container(),

                //laps
                context.watch<TimerProvider>().laps.isEmpty
                    ? Container()
                    : Expanded(
                        child: ListView.builder(
                        itemCount: context.watch<TimerProvider>().laps.length,
                        itemBuilder: (context, index) {
                          return Consumer<TimerProvider>(
                            builder: (context, value, child) {
                              final lap = value.laps[index];
                              return Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.all(15).copyWith(bottom: 0),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade700,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  leading: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      color: Colors.grey.shade200,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  title: Text(
                                    "${lap.hour} : ${lap.minute} : ${lap.second} : ${lap.mSecond}",
                                    style: TextStyle(
                                      color: Colors.grey.shade200,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  //trailling
                                  trailing: IconButton(
                                    onPressed: () {
                                      //delete
                                      context
                                          .read<TimerProvider>()
                                          .delete(index);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ))
              ],
            ),
          ),

          //options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //first option
              myButton(
                onTap: () {
                  context.read<TimerProvider>().restore();
                },
                child: Icon(
                  Icons.restore,
                  color: Colors.grey.shade400,
                ),
              ),

              //second option
              myButton(
                onTap: () {
                  context.read<TimerProvider>().start();
                },
                child: Icon(
                  context.watch<TimerProvider>().isrunning
                      ? Icons.pause_outlined
                      : Icons.play_arrow_rounded,
                  color: Colors.grey.shade400,
                ),
              ),

              //third option
              myButton(
                onTap: () {
                  context.read<TimerProvider>().lap();
                },
                child: Text(
                  "Lap",
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          //sizebox
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
