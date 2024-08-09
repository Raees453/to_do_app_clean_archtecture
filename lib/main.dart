import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/injection/dependency_injection.dart';
import 'package:to_do_app/core/services/router.dart';
import 'package:to_do_app/firebase_options.dart';
import 'package:to_do_app/src/auth/data/models/local_user_model.dart';
import 'package:to_do_app/src/auth/presentation/provider/auth_provider.dart';

final parentScope = ProviderContainer();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await DependencyInjectionEnv.init();
  final user = instance<FirebaseAuth>().currentUser;

  if (user != null) {
    parentScope.read(authStateProvider.notifier).updateState(LocalUserModel.fromFirebaseUser(user));
  }

  runApp(ProviderScope(observers: parentScope.observers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.deepPurple,
        fontFamily: GoogleFonts.poppins().fontFamily,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      onGenerateRoute: onGenerateRoute,
    );
  }
}
