class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String postsEndpoint = '/posts';
  static const int connectTimeout = 10000; // 10s
  static const int receiveTimeout = 10000; // 10s

  static String getImageUrl(int id) {
    return 'https://picsum.photos/seed/$id/400/300';
  }
}
