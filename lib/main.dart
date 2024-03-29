import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  TextEditingController _controller = TextEditingController();
  Timer? _timer;
  int _timeInSeconds = 0;
  int _inputTime = 0;

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _timeInSeconds = _inputTime * 60;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeInSeconds > 0) {
        setState(() {
          _timeInSeconds--;
        });
      } else {
        _timer!.cancel();
        // Optionally, add logic to show a "Time's Up!" message
      }
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void _continueTimer() {
    if (_timer != null) {
      int remainingTime = _timeInSeconds;
      _timer!.cancel();
      setState(() {
        _timeInSeconds = remainingTime;
      });
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_timeInSeconds > 0) {
          setState(() {
            _timeInSeconds--;
          });
        } else {
          _timer!.cancel();
          // Optionally, add logic to show a "Time's Up!" message
        }
      });
    }
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _timeInSeconds = 0;
      _controller.clear();
    });
  }

  String _printDuration(int seconds) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(seconds ~/ 60);
    final remainingSeconds = twoDigits(seconds % 60);
    return "$minutes:$remainingSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer App'),
      ),
      body: Card(
        margin: EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Amanda Dyah Pravitasari\n222410102033',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Masukan Menit'),
                onChanged: (value) {
                  setState(() {
                    _inputTime = int.tryParse(value ?? '') ?? 0;
                    _timeInSeconds = _inputTime * 60;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: _startTimer,
                        child: Text('START'),
                      ),
                      ElevatedButton(
                        onPressed: _stopTimer,
                        child: Text('STOP'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: _resetTimer,
                        child: Text('RESET'),
                      ),
                      ElevatedButton(
                        onPressed: _continueTimer,
                        child: Text('CONTINUE'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(_printDuration(_timeInSeconds)),
            ],
          ),
        ),
      ),
    );
  }
}
