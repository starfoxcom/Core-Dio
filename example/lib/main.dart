import 'package:core_dio/core_dio.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize CoreDio before running the app
  await CoreDio.initialize(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeoutInSeconds: 15,
    receiveTimeoutInSeconds: 15,
    headers: {'Content-Type': 'application/json'},
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoreDio Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CoreDio Example'),
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
  final CoreDio _coreDio = CoreDio();
  String _responseText = 'Press a button to make an HTTP request';
  bool _isLoading = false;

  Future<void> _makeGetRequest() async {
    setState(() {
      _isLoading = true;
      _responseText = 'Making GET request...';
    });

    try {
      final response = await _coreDio.get('/posts/1');
      setState(() {
        _responseText =
            'GET Success!\n'
            'Status Code: ${response.statusCode}\n'
            'Title: ${response.data['title']}\n'
            'Body: ${response.data['body']}';
      });
    } catch (e) {
      setState(() {
        _responseText = 'GET Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _makePostRequest() async {
    setState(() {
      _isLoading = true;
      _responseText = 'Making POST request...';
    });

    try {
      final response = await _coreDio.post(
        '/posts',
        data: {
          'title': 'New Post from CoreDio',
          'body': 'This post was created using CoreDio package!',
          'userId': 1,
        },
      );
      setState(() {
        _responseText =
            'POST Success!\n'
            'Status Code: ${response.statusCode}\n'
            'Created ID: ${response.data['id']}\n'
            'Title: ${response.data['title']}';
      });
    } catch (e) {
      setState(() {
        _responseText = 'POST Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _makePutRequest() async {
    setState(() {
      _isLoading = true;
      _responseText = 'Making PUT request...';
    });

    try {
      final response = await _coreDio.put(
        '/posts/1',
        data: {
          'id': 1,
          'title': 'Updated Post via CoreDio',
          'body': 'This post was updated using CoreDio package!',
          'userId': 1,
        },
      );
      setState(() {
        _responseText =
            'PUT Success!\n'
            'Status Code: ${response.statusCode}\n'
            'Updated Title: ${response.data['title']}';
      });
    } catch (e) {
      setState(() {
        _responseText = 'PUT Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _makeDeleteRequest() async {
    setState(() {
      _isLoading = true;
      _responseText = 'Making DELETE request...';
    });

    try {
      final response = await _coreDio.delete('/posts/1');
      setState(() {
        _responseText =
            'DELETE Success!\n'
            'Status Code: ${response.statusCode}\n'
            'Resource deleted successfully';
      });
    } catch (e) {
      setState(() {
        _responseText = 'DELETE Error: $e';
      });
    } finally {
      setState(() {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'CoreDio HTTP Operations Example',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // HTTP Method Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _makeGetRequest,
                    child: const Text('GET'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _makePostRequest,
                    child: const Text('POST'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _makePutRequest,
                    child: const Text('PUT'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _makeDeleteRequest,
                    child: const Text('DELETE'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Response Display
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _isLoading
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Processing request...'),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: Text(
                          _responseText,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            // Status Info
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CoreDio Status',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text('Initialized: ${CoreDio.isInitialized}'),
                  Text('Base URL: https://jsonplaceholder.typicode.com'),
                  Text('Timeout: 15 seconds'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
