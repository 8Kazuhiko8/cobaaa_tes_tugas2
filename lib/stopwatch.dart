import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void _startStopwatch() {
    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
    _stopwatch.start();
  }

  void _stopStopwatch() {
    _timer?.cancel();
    _stopwatch.stop();
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    setState(() {});
  }

  String _formatTime(int milliseconds) {
    final seconds = (milliseconds / 1000).floor();
    final minutes = (seconds / 60).floor();
    final hours = (minutes / 60).floor();

    // Mendapatkan detik dan milidetik yang lebih detail
    final remainingSeconds = seconds % 60;
    final remainingMinutes = minutes % 60;

    // Menghitung milidetik dan membaginya untuk mendapatkan dua angka di belakang koma
    final milliSeconds = (milliseconds % 1000) / 10;

    return '${hours.toString().padLeft(2, '0')}:'
        '${remainingMinutes.toString().padLeft(2, '0')}:'
        '${remainingSeconds.toString().padLeft(2, '0')}.'
        '${milliSeconds.toStringAsFixed(2).padLeft(2, '0')}'; // Menampilkan dua angka di belakang koma
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
        backgroundColor: Colors.brown[200],
      ),
      body: Container(
        color: Colors.lightBlue[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(_stopwatch.elapsed.inMilliseconds), // Menggunakan fungsi untuk format waktu
              style: TextStyle(fontSize: 48),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _startStopwatch, child: Text('Start')),
                SizedBox(width: 10), // Menambahkan jarak antara tombol
                ElevatedButton(onPressed: _stopStopwatch, child: Text('Stop')),
                SizedBox(width: 10), // Menambahkan jarak antara tombol
                ElevatedButton(onPressed: _resetStopwatch, child: Text('Reset')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
