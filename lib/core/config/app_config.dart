import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../network/dio_client.dart';
import '../../data/repositories/stock_repository_impl.dart';
import '../../domain/repositories/stock_repository.dart';

/// 应用程序配置
class AppConfig {
  const AppConfig._();

  /// 应用程序标题
  static const String appTitle = 'Trading App';

  /// 应用程序主题
  static ThemeData get theme => ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        navigationBarTheme: const NavigationBarThemeData(
          elevation: 0,
        ),
      );
}

final GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Network
  getIt.registerSingleton<DioClient>(DioClient());

  // Repositories
  getIt.registerSingleton<StockRepository>(
    StockRepositoryImpl(dioClient: getIt<DioClient>()),
  );
} 