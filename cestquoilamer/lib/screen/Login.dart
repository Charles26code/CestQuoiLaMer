// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cestquoilamer/reusable_widgets/widget_general.dart';
import 'package:cestquoilamer/screen/DashBoardPage.dart';
import 'package:cestquoilamer/screen/ForgetPassword.dart';
import 'package:cestquoilamer/screen/SignUpScreen.dart';
import 'package:provider/provider.dart';
import 'package:cestquoilamer/models/user_provider.dart';
import 'package:cestquoilamer/models/user_model.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? mailusername;
  String? mdp;

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      try {
        formKey.currentState?.save();
        Map result = await Provider.of<UserProvider>(
          context,
          listen: false,
        ).login(mailusername, mdp);
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(result['message']),
            ),
          );
        if (result['statusCode'] == 200) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const DashBoardPage()),
              (route) => false);
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            const Background(),
            Container(
              decoration: const BoxDecoration(),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const LogoSection(),
                  LoginSection(
                    mailcallback: (value) => mailusername = value,
                    mdpcallback: (value) => mdp = value,
                    submitcallback: () => submitForm(),
                  ),
                  //const QuestionSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginSection extends StatelessWidget {
  final void Function(String?)? mailcallback;
  final void Function(String?)? mdpcallback;
  final void Function()? submitcallback;

  const LoginSection(
      {Key? key,
      required this.mailcallback,
      required this.mdpcallback,
      required this.submitcallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          champsTextes("Adresse Mail ou Nom d'utilisateur",
              Icons.person_outline, false, mailcallback, (value) {
            if (value == null || value.isEmpty) {
              return "Renseigner un nom d'utilisateur ou un email.";
            }
            return null;
          }),
          const SizedBox(
            height: 20,
          ),
          champsTextes("Mot de passe ", Icons.lock_outlined, true, mdpcallback,
              (value) {
            if (value == null || value.isEmpty) {
              return "Renseigner un mot de passe.";
            }
            return null;
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgetPassword()))
                      },
                  child: const Text(
                    'Mot de passe oublié ?',
                    style: TextStyle(
                        color: Color.fromRGBO(254, 183, 1, 1),
                        fontFamily: 'Montserrat',
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 325,
            child: FloatingActionButton.extended(
              backgroundColor: const Color.fromRGBO(254, 183, 1, 1),
              hoverColor: const Color.fromRGBO(254, 183, 1, 1),
              onPressed: submitcallback,
              label: const Text(
                'CONNEXION',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: <Widget>[
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
    ]);
  }
}

class LogoSection extends StatelessWidget {
  const LogoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: const Text('Sakartone 📦',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(254, 183, 1, 1),
                        fontFamily: 'Pacifico',
                        fontSize: 50,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          )),
    ]);
  }
}

class QuestionSection extends StatelessWidget {
  const QuestionSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashBoardPage()));
                },
                child: const Text(
                  'Créer un compte ->',
                  style: TextStyle(
                      color: Color.fromRGBO(254, 183, 1, 1),
                      fontFamily: 'Montserrat',
                      fontSize: 13),
                )),
          ],
        ),
      ),
    );
  }
}
