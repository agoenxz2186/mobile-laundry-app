import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
               const Text('Email'),
               TextFormField(

               ),
               const SizedBox(height: 20,),
               const Text('Password'),
               TextFormField(
                  obscureText: true,
               ),
               const SizedBox(height: 20,),
               ElevatedButton(onPressed: (){

               }, child: const Text('Login'))
               
            ],
          ),
        ),
    );
  }
}