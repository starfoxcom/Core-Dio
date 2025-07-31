import 'package:core_logger/core_logger.dart';
import 'package:dio/dio.dart';

/// A [Dio] class for the core of a project.
class CoreDio {
  /// Returns the singleton instance of [CoreDio].
  factory CoreDio() {
    return _instance;
  }

  /// Private constructor for singleton pattern.
  CoreDio._internal();

  /// The singleton instance of [CoreDio].
  static final CoreDio _instance = CoreDio._internal();

  /// The [Dio] instance used for making HTTP requests.
  late Dio _dio;

  /// Whether the [CoreDio] has been initialized.
  static bool _isInitialized = false;

  /// Initializes the [Dio].
  ///
  /// This method should be called before using any other methods of [CoreDio].
  ///
  /// The [baseUrl] is the base URL for all requests.
  /// Defaults to an `empty` [String], which means no base URL is set.
  ///
  /// The [connectTimeoutInSeconds] and [receiveTimeoutInSeconds] specify the timeouts for connections and responses, respectively.
  /// Defaults are `30 seconds` each.
  ///
  /// The [headers] can be provided to set default headers for all requests.
  /// Defaults to `null`, meaning no additional headers are set.
  ///
  /// Example:
  /// ```dart
  /// final dio = CoreDio();
  ///
  /// // Don't forget to initialize the dio first before making requests!
  /// dio.initialize(
  ///   baseUrl: 'https://api.example.com',
  ///   connectTimeoutInSeconds: 30,
  ///   receiveTimeoutInSeconds: 30,
  ///   headers: {
  ///     'Authorization': 'Bearer YOUR_TOKEN',
  ///   },
  /// );
  /// ```
  static Future<void> initialize({
    String baseUrl = '',
    int connectTimeoutInSeconds = 30,
    int receiveTimeoutInSeconds = 30,
    Map<String, dynamic>? headers,
  }) async {
    if (!CoreLogger.isInitialized) {
      await CoreLogger.initialize();
    } else {
      CoreLogger().info('CoreLogger is already initialized.');
    }

    CoreLogger().info('Initializing CoreDio');
    _instance._dio = Dio();
    _instance._dio.options.baseUrl = baseUrl;
    _instance._dio.options.connectTimeout = Duration(
      seconds: connectTimeoutInSeconds,
    );
    _instance._dio.options.receiveTimeout = Duration(
      seconds: receiveTimeoutInSeconds,
    );
    if (headers != null) {
      _instance._dio.options.headers.addAll(headers);
    }
    _isInitialized = true;
    CoreLogger().success('CoreDio initialized!');
  }

  /// Checks if [CoreDio] is initialized.
  ///
  /// Returns `true` if initialized, otherwise `false`.
  static bool get isInitialized => _isInitialized;

  /// Throws an exception if [CoreDio] is not initialized.
  static void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError(
        '[CoreDio] is not initialized. Call CoreDio.initialize() before using it.',
      );
    }
  }

  /// Makes a `GET` request.
  ///
  /// The [path] is the endpoint to which the request is made.
  ///
  /// The [data] can be provided for the request body.
  ///
  /// The [headers] can be provided to set additional headers for the request aside from the default headers, if any.
  ///
  /// The [queryParameters] can be provided to set query parameters for the request.
  ///
  /// `Returns` the [Response] data.
  ///
  /// If the request fails, it will throw a [DioException].
  ///
  /// Example of a simple `GET` request:
  /// ```dart
  /// // Don't forget to initialize the dio first!
  /// // GET request
  /// final response = await dio.get('/posts/1');
  /// if (response.statusCode == 200) {
  ///   // Handle successful response
  /// }
  /// ```
  ///
  /// Example of a `GET` request with data, headers and query parameters:
  /// ```dart
  /// // GET request with data, headers and query parameters
  /// final response = await dio.get(
  ///   '/posts',
  ///   data: {'key': 'value'},
  ///   headers: {'Authorization': 'Bearer YOUR_TOKEN'},
  ///   queryParameters: {'search': 'query'},
  /// );
  /// if (response.statusCode == 200) {
  ///   // Handle successful response
  /// }
  /// ```
  Future<Response<T>> get<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    _ensureInitialized();
    CoreLogger().info('Making GET request to ${_dio.options.baseUrl}$path');
    try {
      final response = await _dio.get<T>(
        path,
        data: data,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      CoreLogger().success(
        'GET request successful: ${_dio.options.baseUrl}$path | status code: ${response.statusCode}',
        response,
      );
      return response;
    } on DioException catch (e) {
      CoreLogger().error(
        'GET request failed: ${_dio.options.baseUrl}$path | status code: ${e.response?.statusCode}',
        e,
      );
      rethrow;
    }
  }

  /// Makes a `POST` request.
  ///
  /// The [path] is the endpoint to which the request is made.
  ///
  /// The [data] can be provided for the request body.
  ///
  /// The [headers] can be provided to set additional headers for the request aside from the default headers, if any.
  ///
  /// The [queryParameters] can be provided to set query parameters for the request.
  ///
  /// `Returns` the [Response] data.
  ///
  /// If the request fails, it will throw a [DioException].
  ///
  /// Example of a simple `POST` request:
  /// ```dart
  /// // POST request
  /// final response = await dio.post('/posts', data: {'title': 'New Post'});
  /// if (response.statusCode == 201) {
  ///   // Handle successful response
  /// }
  /// ```
  ///
  /// Example of a `POST` request with data, headers and query parameters:
  /// ```dart
  /// // POST request with data, headers and query parameters
  /// final response = await dio.post(
  ///   '/posts',
  ///   data: {'title': 'New Post'},
  ///   headers: {'Authorization': 'Bearer YOUR_TOKEN'},
  ///   queryParameters: {'search': 'query'},
  /// );
  /// if (response.statusCode == 201) {
  ///   // Handle successful response
  /// }
  /// ```
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    _ensureInitialized();
    CoreLogger().info('Making POST request to ${_dio.options.baseUrl}$path');
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      CoreLogger().success(
        'POST request successful: ${_dio.options.baseUrl}$path | status code: ${response.statusCode}',
        response,
      );
      return response;
    } on DioException catch (e) {
      CoreLogger().error(
        'POST request failed: ${_dio.options.baseUrl}$path | status code: ${e.response?.statusCode}',
        e,
      );
      rethrow;
    }
  }

  /// Makes a `PUT` request.
  ///
  /// The [path] is the endpoint to which the request is made.
  ///
  /// The [data] can be provided for the request body.
  ///
  /// The [headers] can be provided to set additional headers for the request aside from the default headers, if any.
  ///
  /// The [queryParameters] can be provided to set query parameters for the request.
  ///
  /// `Returns` the [Response] data.
  ///
  /// If the request fails, it will throw a [DioException].
  ///
  /// Example of a simple `PUT` request:
  /// ```dart
  /// // PUT request
  /// final response = await dio.put('/posts/1', data: {'title': 'Updated Post'});
  /// if (response.statusCode == 200) {
  ///   // Handle successful response
  /// }
  /// ```
  ///
  /// Example of a `PUT` request with data, headers and query parameters:
  /// ```dart
  /// // PUT request with data, headers and query parameters
  /// final response = await dio.put(
  ///   '/posts/1',
  ///   data: {'title': 'Updated Post'},
  ///   headers: {'Authorization': 'Bearer YOUR_TOKEN'},
  ///   queryParameters: {'search': 'query'},
  /// );
  /// if (response.statusCode == 200) {
  ///   // Handle successful response
  /// }
  /// ```
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    _ensureInitialized();
    CoreLogger().info('Making PUT request to ${_dio.options.baseUrl}$path');
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      CoreLogger().success(
        'PUT request successful: ${_dio.options.baseUrl}$path | status code: ${response.statusCode}',
        response,
      );
      return response;
    } on DioException catch (e) {
      CoreLogger().error(
        'PUT request failed: ${_dio.options.baseUrl}$path | status code: ${e.response?.statusCode}',
        e,
      );
      rethrow;
    }
  }

  /// Makes a `DELETE` request.
  ///
  /// The [path] is the endpoint to which the request is made.
  ///
  /// The [data] can be provided for the request body.
  ///
  /// The [headers] can be provided to set additional headers for the request aside from the default headers, if any.
  ///
  /// The [queryParameters] can be provided to set query parameters for the request.
  ///
  /// `Returns` the [Response] data.
  ///
  /// If the request fails, it will throw a [DioException].
  ///
  /// Example of a simple `DELETE` request:
  /// ```dart
  /// // DELETE request
  /// final response = await dio.delete('/posts/1');
  /// if (response.statusCode == 200) {
  ///   // Handle successful response
  /// }
  /// ```
  ///
  /// Example of a `DELETE` request with data, headers and query parameters:
  /// ```dart
  /// // DELETE request with data, headers and query parameters
  /// final response = await dio.delete(
  ///   '/posts/1',
  ///   data: {'title': 'Updated Post'},
  ///   headers: {'Authorization': 'Bearer YOUR_TOKEN'},
  ///   queryParameters: {'search': 'query'},
  /// );
  /// if (response.statusCode == 200) {
  ///   // Handle successful response
  /// }
  /// ```
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    _ensureInitialized();
    CoreLogger().info('Making DELETE request to ${_dio.options.baseUrl}$path');
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      CoreLogger().success(
        'DELETE request successful: ${_dio.options.baseUrl}$path | status code: ${response.statusCode}',
        response,
      );
      return response;
    } on DioException catch (e) {
      CoreLogger().error(
        'DELETE request failed: ${_dio.options.baseUrl}$path | status code: ${e.response?.statusCode}',
        e,
      );
      rethrow;
    }
  }
}
