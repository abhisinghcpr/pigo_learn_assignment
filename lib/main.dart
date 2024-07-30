import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/view/screens/splash/splash_screen.dart';
import 'package:flutter_task/view/utils/colors/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'controller/provider/auth_provider.dart';
import 'controller/provider/product_provider.dart';
import 'firebase_options.dart';
import 'get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        title: 'e-Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,

            appBarTheme: const AppBarTheme(
              titleSpacing: 30,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                backgroundColor: AppColors.backgroundColor),
            scaffoldBackgroundColor: AppColors.backgroundColor,
            fontFamily: GoogleFonts.poppins().fontFamily,
            textTheme: GoogleFonts.poppinsTextTheme()),
                home: SplashScreen(),
      ),
    );
  }
}
