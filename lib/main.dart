import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_getx/config/theme/app_theme.dart';
import 'package:mvvm_getx/di/init_dependency.dart';
import 'package:mvvm_getx/ui/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitDependency(),
      home: const HomeScreen(),
      theme: AppTheme().getTheme(),
    );
  }
}
