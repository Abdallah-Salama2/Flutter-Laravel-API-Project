import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/categories.dart';
import 'package:flutter_application_1/providers/CategoryProvider.dart';
import 'package:flutter_application_1/providers/authProvider.dart';
import 'package:provider/provider.dart';

import 'values/app_theme.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'values/app_constants.dart';
import 'values/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then(
    (_) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<CategoryProvider>(
                    create: (context) => CategoryProvider()),
                ChangeNotifierProvider<AuthProvider>(
                    create: (context) => AuthProvider())
              ],
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Login and Register UI',
                  theme: AppTheme.themeData,
                  initialRoute: AppRoutes.loginScreen,
                  navigatorKey: AppConstants.navigationKey,
                  routes: {
                    '/': (context) {
                      final authProvider = Provider.of<AuthProvider>(context);
                      if (authProvider.isAuthenticated) {
                        return Categories();
                      } else {
                        return LoginPage();
                      }
                    },
                    AppRoutes.loginScreen: (context) => const LoginPage(),
                    AppRoutes.registerScreen: (context) => const RegisterPage(),
                    AppRoutes.category: (context) => Categories(),
                  }));
        }));
  }
}
