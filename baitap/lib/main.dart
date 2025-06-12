import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lấy dữ liệu server',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Lấy dữ liệu server'),
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
  String _serverData = 'Chưa có dữ liệu';
  bool _isLoading = false;

  Future<void> _fetchDataFromServer() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Giả lập lấy dữ liệu từ server với delay 2 giây
      final data = await Future.delayed(
        const Duration(seconds: 2),
        () => 'Dữ liệu server (lấy lúc ${DateTime.now()})',
      );

      setState(() {
        _serverData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _serverData = 'Lỗi khi lấy dữ liệu: $e';
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
                : Text(
                    _serverData,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchDataFromServer,
              child: const Text('Lấy dữ liệu từ server'),
            ),
          ],
        ),
      ),
    );
  }
}