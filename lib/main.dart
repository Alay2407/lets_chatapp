import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_chatapp/Presentation/authentication/welcomePage.dart';
import 'package:lets_chatapp/Presentation/screen/home_Screen.dart';
import 'package:lets_chatapp/core/routes/generate_routers.dart';
import 'package:lets_chatapp/domain/bloc/auth/login_bloc/login_bloc.dart';
import 'package:lets_chatapp/domain/bloc/auth/signup_bloc/signup_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/shared_preferences/SharedPreferenceHelper.dart';
import 'getit_injector.dart' as di;
import 'getit_injector.dart';

Future<void> main() async {
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  WidgetsFlutterBinding.ensureInitialized();
  di.init();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  // SharedPreferenceHelper _pref = SharedPreferenceHelper(prefs: preferences);
  SharedPreferenceHelper(prefs: preferences);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _prefs = locator.get<SharedPreferenceHelper>();
    print("Access token is ${_prefs.getValues('token')}");
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => di.locator<SignupBloc>(),
          ),
          BlocProvider(
            create: (context) => di.locator<LoginBloc>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          onGenerateRoute: onGenerate,
          home: _prefs.getValues('token') != null ? const HomeScreen() : const FirstPage(),
        ));
  }
}
