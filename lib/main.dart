import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '/screens/get_started_screen.dart';
import '/screens/login_screen.dart';
import '/screens/register_screen.dart';
import '/screens/welcome_screen.dart';
import 'package:final_year_project/screens/lost_found_screen.dart';
import '/screens/report_screen.dart';
import '/screens/report_list_screen.dart';
import '/screens/profile_screen.dart';
import '/screens/users_screen.dart';
import '/screens/forgot_password_screen.dart';
import '/screens/verify_email_screen.dart';
import '/screens/verify_code_screen.dart';
import '/screens/password_reset_screen.dart';
import '/screens/new_password_screen.dart';
import '/screens/password_updated_screen.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyCiYPuN-HfetkSBFsbemdEOcy3PskA6QUI", appId: "1:668200457158:web:add1cdb84b0f71b86ad8c7", messagingSenderId: "668200457158", projectId: "fyp-firebase-fc910"));
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lost & Found',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const GetStartedScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/lost_found': (context) => const LostFoundScreen(),
        '/report_list': (context) => const ReportListScreen(isLostItem: true), //isme isLostItem param new  ha
        '/profile': (context) => const ProfileScreen(),
        '/users': (context) => const UsersScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/verify_email': (context) => const VerifyEmailScreen(),
        '/verify_code': (context) => const VerifyCodeScreen(),
        '/password_reset': (context) => const PasswordResetScreen(),
        '/new_password': (context) => const NewPasswordScreen(),
        '/password_updated': (context) => const PasswordUpdatedScreen(),

      },
      onGenerateRoute: (settings) {
        if (settings.name == '/report') {
          final args = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (context) {
              return ReportScreen(isLostItem: args?['isLostItem'] ?? true);
            },
          );
        }
        return null;
      },
    );
  }
}






