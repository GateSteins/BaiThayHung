import 'package:flutter/material.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final tong = await tinhTong();
  runApp(MyApp(tong: tong));
}

Future<int> tinhTong() async {
  // Mô phỏng tính toán lâu
  await Future.delayed(const Duration(seconds: 2));
  int sum = 0;
  for (int i = 1; i <= 1000000; i++) {
    sum += i;
  }
  return sum;
}

class MyApp extends StatelessWidget {
  final int tong;
  const MyApp({super.key, required this.tong});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tính tổng bất đồng bộ',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tính tổng bất đồng bộ'),
        ),
        body: Center(
          child: Text(
            'Tổng từ 1 tới 1.000.000 là: $tong',
            style: const TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
