import 'package:flutter/material.dart';
import 'core/config/app_config.dart';
import 'core/di/app_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppModule.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.appTitle,
      theme: AppConfig.theme,
      routerConfig: AppModule.routerService.config,
    );
  }
}
