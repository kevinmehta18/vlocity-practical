import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practical/domain/providers/dashboard_provider.dart';
import 'package:practical/domain/providers/movies_provider.dart';
import 'package:practical/domain/providers/todo_provider.dart';
import 'package:practical/shared/constants/miscellaneous.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import 'shared/constants/themes.dart';
import 'shared/navigation/app_router.dart';
import 'shared/utils/responsive_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => DashboardProvider()),
    ChangeNotifierProvider(create: (_) => TodoProvider()),
    ChangeNotifierProvider(create: (_) => MoviesProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveManager.init(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    return ToastificationWrapper(
      config: const ToastificationConfig(
          animationDuration: kToastAnimationDuration),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Vlocity Practical',
        routerConfig: router,
        theme: lightTheme,
        themeMode: ThemeMode.light,
        themeAnimationCurve: Curves.easeIn,
        scrollBehavior: const ScrollBehavior(),
      ),
    );
    ;
  }
}
