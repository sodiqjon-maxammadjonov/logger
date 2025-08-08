class AppConstants {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const int connectionTimeout = 30;
  static const int receiveTimeout = 30;

  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';

  static const String appName = 'Flutter Clean App';
  static const String appVersion = '1.0.0';

  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 400);
  static const Duration longAnimationDuration = Duration(milliseconds: 800);
}