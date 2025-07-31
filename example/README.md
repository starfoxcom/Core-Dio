# Core Dio Example

This example app demonstrates how to use the CoreDio package in a Flutter application.

## Features Demonstrated

- **HTTP Client Initialization**: Shows how to properly initialize CoreDio with custom configuration
- **All HTTP Methods**: Demonstrates GET, POST, PUT, and DELETE operations
- **Error Handling**: Shows proper error handling with DioException
- **Loading States**: Displays loading indicators during network requests
- **Response Display**: Shows how to handle and display API responses
- **Initialization Check**: Verifies CoreDio initialization status

## How to Run

1. Make sure you're in the example directory:
   ```bash
   cd example
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## What You'll See

- **HTTP Method Buttons**: Four buttons for GET, POST, PUT, and DELETE operations
- **Response Display Area**: Shows request results, status codes, and response data
- **Loading States**: Circular progress indicator during active requests
- **Status Information**: Displays CoreDio initialization status and configuration
- **Error Handling**: Shows error messages when requests fail

## API Integration

This example uses [JSONPlaceholder](https://jsonplaceholder.typicode.com/), a free fake REST API that provides:
- **GET /posts/1**: Fetches a single post
- **POST /posts**: Creates a new post
- **PUT /posts/1**: Updates an existing post
- **DELETE /posts/1**: Deletes a post

## Code Highlights

### Initialization
```dart
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
```

### Usage
```dart
final coreDio = CoreDio();

// GET request
final response = await coreDio.get('/posts/1');

// POST request with data
final response = await coreDio.post(
  '/posts',
  data: {
    'title': 'New Post',
    'body': 'Post content',
    'userId': 1,
  },
);

// PUT request with headers
final response = await coreDio.put(
  '/posts/1',
  data: {'title': 'Updated Post'},
  headers: {'Authorization': 'Bearer token'},
);

// DELETE request
final response = await coreDio.delete('/posts/1');
```

### Error Handling
```dart
try {
  final response = await coreDio.get('/posts/1');
  print('Success: ${response.statusCode}');
} on DioException catch (e) {
  print('Error: ${e.message}');
}
```

### Initialization Check
```dart
if (CoreDio.isInitialized) {
  // Safe to make requests
  final response = await coreDio.get('/posts');
} else {
  // Handle uninitialized state
  print('CoreDio not initialized');
}
```

This example serves as a practical reference for integrating CoreDio into your own Flutter applications.
