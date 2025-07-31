# Core Dio

A robust and efficient Flutter package that provides a singleton HTTP client wrapper around the popular `dio` package. Core Dio offers a clean, easy-to-use interface for making HTTP requests throughout your Flutter application with consistent configuration, automatic logging, and comprehensive error handling.

> **Note**: This is a local package not published to pub.dev. Use the local path dependency or git dependency method to include it in your projects.

## Features

- **Singleton Pattern**: Access the same HTTP client instance throughout your entire application
- **Multiple HTTP Methods**: Support for GET, POST, PUT, and DELETE operations
- **Built on Dio Package**: Leverages the robust and popular `dio` package for HTTP operations
- **Automatic Logging**: Integrated with [CoreLogger](https://github.com/starfoxcom/Core-Logger) for comprehensive request/response logging
- **Easy Configuration**: Simple initialization with base URL, timeouts, and default headers
- **Error Handling**: Built-in error handling with detailed logging and proper exception propagation
- **Type Safety**: Full Dart type safety with generic response types and optional parameters
- **Initialization Validation**: Ensures the client is properly initialized before making requests

## Getting started

Since this is a local package not published to pub.dev, you can add it to your project using either a local path dependency or a git dependency:

### Option 1: Local Path Dependency

Add it to your project's `pubspec.yaml` file using a local path:

```yaml
dependencies:
  flutter:
    sdk: flutter
  core_dio:
    path: ../path/to/core_dio  # Update with the actual path to this package
```

### Option 2: Git Dependency

Add it to your project's `pubspec.yaml` file using the git repository:

```yaml
dependencies:
  flutter:
    sdk: flutter
  core_dio:
    git:
      url: https://github.com/starfoxcom/Core-Dio.git
      # ref: main  # Optional: specify a branch, tag, or commit
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Setup

First, initialize CoreDio in your app's main function:

```dart
import 'package:core_dio/core_dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize CoreDio before using it
  await CoreDio.initialize(
    baseUrl: 'https://api.example.com',
    connectTimeoutInSeconds: 30,
    receiveTimeoutInSeconds: 30,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer YOUR_TOKEN',
    },
  );
  
  runApp(MyApp());
}
```

### Making HTTP Requests

Once initialized, you can use CoreDio anywhere in your application:

```dart
import 'package:core_dio/core_dio.dart';

class ApiService {
  final coreDio = CoreDio();
  
  Future<void> fetchData() async {
    try {
      // GET request
      final response = await coreDio.get('/posts/1');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');
      
    } on DioException catch (e) {
      print('Error: ${e.message}');
    }
  }
  
  Future<void> createPost() async {
    try {
      // POST request with data
      final response = await coreDio.post(
        '/posts',
        data: {
          'title': 'New Post',
          'body': 'Post content',
          'userId': 1,
        },
      );
      print('Created: ${response.data}');
      
    } on DioException catch (e) {
      print('Error: ${e.message}');
    }
  }
  
  Future<void> updatePost(int id) async {
    try {
      // PUT request with custom headers
      final response = await coreDio.put(
        '/posts/$id',
        data: {'title': 'Updated Post'},
        headers: {'X-Custom-Header': 'value'},
      );
      print('Updated: ${response.data}');
      
    } on DioException catch (e) {
      print('Error: ${e.message}');
    }
  }
  
  Future<void> deletePost(int id) async {
    try {
      // DELETE request
      final response = await coreDio.delete('/posts/$id');
      print('Deleted successfully');
      
    } on DioException catch (e) {
      print('Error: ${e.message}');
    }
  }
}
```

You can also use CoreDio directly without assigning it to a variable, due to the singleton nature of the `CoreDio` class:

```dart
import 'package:core_dio/core_dio.dart';

class ApiService {
  Future<void> fetchUser(int userId) async {
    try {
      // Direct usage
      final response = await CoreDio().get('/users/$userId');
      print('User: ${response.data}');
      
    } on DioException catch (e) {
      print('Error: ${e.message}');
    }
  }
}
```

### Available HTTP Methods

- `coreDio.get<T>(path, {data, headers, queryParameters})` - GET requests
- `coreDio.post<T>(path, {data, headers, queryParameters})` - POST requests
- `coreDio.put<T>(path, {data, headers, queryParameters})` - PUT requests
- `coreDio.delete<T>(path, {data, headers, queryParameters})` - DELETE requests

### Initialization Check

You can verify if CoreDio is properly initialized:

```dart
if (CoreDio.isInitialized) {
  // Safe to make requests
  final response = await CoreDio().get('/posts');
} else {
  // Handle uninitialized state
  print('CoreDio not initialized');
}
```

## Additional information

This package provides a robust wrapper around the `dio` package with the following benefits:

- **Singleton pattern**: Ensures consistent HTTP client configuration across your entire application
- **Automatic logging**: Integrated with CoreLogger to track all HTTP requests and responses
- **Configuration management**: Centralized setup for base URLs, timeouts, and default headers
- **Error handling**: Comprehensive error handling with detailed logging
- **Flutter optimized**: Designed specifically for Flutter applications
- **Testing included**: Comprehensive test suite to ensure reliability

### Local Package Usage

Since this is a local package, you can:

1. **Clone or copy** this package to your local development environment
2. **Reference it** in your project's `pubspec.yaml` using a relative path
3. **Modify it** to suit your specific HTTP client needs
4. **Version control** it alongside your project or as a separate repository

### Example App

Check out the `/example` folder for a complete Flutter application demonstrating all CoreDio features, including:

- Initialization setup
- All HTTP methods (GET, POST, PUT, DELETE)
- Error handling
- Loading states
- Response display

### Contributing

If you're using this package and want to contribute improvements:

1. Fork or clone the repository
2. Make your changes
3. Run the tests: `flutter test`
4. Submit your improvements
