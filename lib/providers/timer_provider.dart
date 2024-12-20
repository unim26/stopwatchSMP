import 'dart:async';

import 'package:counter_provider/model/lap_model.dart';
import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  int _hour = 00;
  int _minute = 00;
  int _second = 00;
  int _msecond = 00;
  bool _isrunning = false;
  List<LapModel> _laps = [];

  int get hour => _hour;
  int get minute => _minute;
  int get second => _second;
  int get mSecond => _msecond;
  bool get isrunning => _isrunning;
  List<LapModel> get laps => _laps;

  //start
  void start() {
    _isrunning = !_isrunning;

    if (isrunning) {
      Timer.periodic(
        Duration(milliseconds: 1),
        (timer) {
          //start stop
          if (isrunning) {
            //start from msecodn
            _msecond++;

            //if if millisecond is full
            if (_msecond == 1000) {
              _msecond = 0;
              _second++;
            } else if (_second == 60) {
              _second = 0;
              _minute++;
            } else if (_minute == 60) {
              _minute = 0;
              _hour++;
            }

            notifyListeners();
          } else {
            timer.cancel();
            notifyListeners();
          }
        },
      );
    }
  }

  //restore
  void restore() {
    _isrunning = false;
    _laps.clear();
    _hour = 0;
    _minute = 0;
    _second = 0;
    _msecond = 0;
    notifyListeners();
  }

  //lap
  void lap() {
    if (isrunning) {
      laps.add(
        LapModel(
          hour: _hour,
          minute: _minute,
          second: _second,
          mSecond: _msecond,
        ),
      );
    }
    notifyListeners();
  }

  //deldete lap
  void delete(int index) {
    _laps.removeAt(index);
    notifyListeners();
  }
}
