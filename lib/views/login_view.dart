import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_owner/constants/assets.dart';
import 'package:laundry_owner/painter/wave_painter.dart';
import 'package:laundry_owner/providers/formlogin_providers.dart';
import 'package:laundry_owner/views/dashboard_view.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart' as validator;

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height - 200),
            width: double.infinity,
            height: 200,
            child: CustomPaint(
              painter: WavePainter(),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SafeArea(child: SizedBox()),
                Center(
                  child: Image.asset(
                    Assets.assetsImagesIcon,
                    height: 150,
                  ),
                ),
                const _FormLogin(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FormLogin extends StatelessWidget {
  const _FormLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FormLoginProviders>(
      builder: (bc, prov, w) => Form(
        key: prov.keyForm,
        child: Container(
          margin: const EdgeInsets.fromLTRB(50, 20, 50, 20),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: Offset(2, 2),
                    color: Colors.grey)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Email'),
              TextFormField(
                controller: prov.txtEmail,
                enabled: !prov.loading,
                validator: (value) => value?.isEmpty ?? true
                    ? 'Email tidak boleh kosong'
                    : (validator.isEmail(value ?? '')
                        ? null
                        : 'Gunakan alamat email yang benar'),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Password'),
              TextFormField(
                  controller: prov.txtPass,
                  obscureText: true,
                  enabled: !prov.loading,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Password tidak boleh kosong'
                      : null),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: prov.loading
                    ? const CupertinoActivityIndicator()
                    : _buttonLogin(prov, context),
              )
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _buttonLogin(FormLoginProviders prov, BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (prov.keyForm.currentState?.validate() == false) {
            return;
          }
          prov.submitLogin().then((value) {
            if (value['code'] == 200) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (c) => const DashboardView()));
            } else if (value['code'] >= 408) {
              CherryToast.error(
                title:
                    const Text('Gagal Login karena gagal terhubung ke server'),
                toastDuration: const Duration(seconds: 5),
              ).show(context);
            } else {
              CherryToast.warning(
                title: Text('${value['json']['message']}'),
                toastDuration: const Duration(seconds: 5),
              ).show(context);
            }
          });
        },
        child: const Text('Login'));
  }
}
