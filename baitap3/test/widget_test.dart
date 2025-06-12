// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:baitap3/main.dart';

void main() {
  testWidgets('Hiển thị đúng tổng từ 1 tới 1.000.000', (WidgetTester tester) async {
    // Chờ app khởi tạo và tính toán xong
    await tester.pumpWidget(MyApp(tong: 500000500000));
    // Kiểm tra có hiển thị đúng tổng
    expect(find.text('Tổng từ 1 tới 1.000.000 là: 500000500000'), findsOneWidget);
  });
}
