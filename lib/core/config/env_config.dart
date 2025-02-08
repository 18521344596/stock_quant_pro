/// 环境配置
class EnvConfig {
  const EnvConfig._();

  /// API 基础 URL
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.example.com',
  );

  /// API 超时时间（毫秒）
  static const int timeout = int.fromEnvironment(
    'API_TIMEOUT',
    defaultValue: 30000,
  );

  /// 是否是开发环境
  static const bool isDevelopment = bool.fromEnvironment(
    'IS_DEVELOPMENT',
    defaultValue: true,
  );
} 