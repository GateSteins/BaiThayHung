import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lấy danh sách người dùng từ API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Lấy danh sách người dùng từ API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _userNames = [];
  bool _isLoading = false;

  // Hàm lấy danh sách tên người dùng từ API thật
  Future<List<String>> fetchUserNames() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/users'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Debug: In ra dữ liệu nhận được từ API
      print('API response: ${response.body}');
      // Nếu trả về List
      if (data is List) {
        return data.map<String>((user) {
          if (user is Map) {
            final mapUser = Map<String, dynamic>.from(user);
            return mapUser['username']?.toString() ?? 'Không có username';
          }
          return user.toString();
        }).toList();
      }
      // Nếu trả về Map có key 'users'
      if (data is Map && data.containsKey('users')) {
        final users = data['users'] as List<dynamic>;
        return users.map<String>((user) {
          if (user is Map) {
            final mapUser = Map<String, dynamic>.from(user);
            return mapUser['username']?.toString() ?? 'Không có username';
          }
          return user.toString();
        }).toList();
      }
      throw Exception('API không trả về đúng định dạng (không phải List hoặc thiếu key users)');
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

  Future<void> getAndPrintUserNames() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final names = await fetchUserNames();
      setState(() {
        _userNames = names;
        _isLoading = false;
      });
      for (var name in names) {
        // ignore: avoid_print
        print(name);
      }
    } catch (e) {
      setState(() {
        _userNames = ['Lỗi khi lấy dữ liệu: $e'];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isLoading
                ? const CircularProgressIndicator()
                : _userNames.isEmpty
                    ? const Text('Chưa có dữ liệu người dùng')
                    : Column(
                        children: _userNames
                            .map((name) => Text(name, style: const TextStyle(fontSize: 18)))
                            .toList(),
                      ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : getAndPrintUserNames,
              child: const Text('Lấy danh sách người dùng'),
            ),
          ],
        ),
      ),
    );
  }
}
