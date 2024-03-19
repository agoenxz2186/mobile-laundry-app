import 'package:flutter/material.dart';
import 'package:laundry_owner/utils/global_variable.dart';
import 'package:laundry_owner/views/dashboard_view.dart';
import 'package:laundry_owner/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
 

  runApp( MaterialApp(
    title: 'L-dry Owner',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.grey
          )
        )
      ),
      primaryColor: const Color.fromARGB(255, 11, 122, 150)
    ),
    home: const Appku()
  ) );
}

class Appku extends StatelessWidget {
  const Appku({super.key});

  Future<bool> cekIsLogined()async{
      Global.pref = await SharedPreferences.getInstance();
      final ses = Global.pref?.getString('Session-ID');

      return (ses?.length ?? 0) > 10;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: cekIsLogined(), builder: (context, snapshot) {
      return snapshot.data == true ? const DashboardView() : const LoginView();
    },);
  }
}