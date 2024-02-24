import 'dart:io'; // Importing IO utilities
import 'package:dio/dio.dart'; // Importing Dio for HTTP requests
import 'package:dio/io.dart'; // Importing IO adapter for Dio

class Network with DioMixin implements Dio {
  Network(
    String path, {
    List<Interceptor> interceptors = const [], // List of interceptors
    Duration? connectTimeout =
        const Duration(seconds: 30), // Connect timeout duration
    Duration? sendTimeout =
        const Duration(seconds: 30), // Send timeout duration
    Duration? receiveTimeout =
        const Duration(seconds: 30), // Receive timeout duration
    HttpClientAdapter? adapter, // HTTP client adapter
  }) {
    options = BaseOptions(
      // Setting base options for Dio
      baseUrl: path, // Base URL for requests
      connectTimeout: connectTimeout, // Setting connect timeout
      sendTimeout: sendTimeout, // Setting send timeout
      receiveTimeout: receiveTimeout, // Setting receive timeout
    );

    if (interceptors.isNotEmpty) {
      // Adding interceptors if provided
      interceptors.addAll(interceptors);
    }

    httpClientAdapter = adapter ?? // Setting HTTP client adapter
        IOHttpClientAdapter(
          // Using IOHttpClientAdapter as default
          createHttpClient: () {
            final client = HttpClient(); // Creating HttpClient instance
            client.badCertificateCallback =
                (X509Certificate cert, String host, int port) =>
                    true; // Allowing self-signed certificates
            return client;
          },
        );
  }

  static clone(Dio input) {
    // Static method to clone Dio instance
    Dio dio = Dio(input.options); // Creating new Dio instance with same options
    dio.httpClientAdapter =
        input.httpClientAdapter; // Setting HTTP client adapter
    dio.interceptors.addAll(input.interceptors); // Adding interceptors
    return dio; // Returning cloned Dio instance
  }
}
