import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry_owner/models/auth_model.dart';
import 'package:laundry_owner/providers/dashboard_provider.dart';
import 'package:laundry_owner/providers/formlogin_providers.dart';
import 'package:laundry_owner/providers/formoutlet_provider.dart';
import 'package:laundry_owner/providers/listoutlet_provider.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/views/dashboard_view.dart';
import 'package:laundry_owner/views/login_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => FormLoginProviders()),
        ChangeNotifierProvider(create: (c) => DashboardProvider()),
        ChangeNotifierProvider(create: (c) => ListOutletProvider()),
        ChangeNotifierProvider(create: (c) => FormOutletProvider()),
      ],
      builder: (context, w) {
        return MaterialApp(
            title: 'L-dry Owner',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.nunitoTextTheme(),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Color.fromARGB(255, 240, 100, 19),
                  foregroundColor: Colors.white),
              inputDecorationTheme: InputDecorationTheme(
                  isDense: true,
                  contentPadding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey))),
              primarySwatch: Colors.lightBlue,
              primaryColor: const Color.fromARGB(255, 11, 122, 150),
              appBarTheme: const AppBarTheme(
                  backgroundColor: Color.fromARGB(255, 240, 100, 19),
                  foregroundColor: Color.fromARGB(255, 245, 221, 211)),
            ),
            home: const Appku());
      }));
}

class Appku extends StatelessWidget {
  const Appku({super.key});

  Future<bool> cekIsLogined() async {
    Global.pref = await SharedPreferences.getInstance();
    final user = Global.pref?.getString('user') ?? '';
    // logD("isi user $user");
    Global.auth = AuthModel.fromJson(user);
    return Global.auth?.sessionId?.isNotEmpty ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cekIsLogined(),
      builder: (context, snapshot) {
        return snapshot.data == true
            ? const DashboardView()
            : const LoginView();
      },
    );
  }
}
