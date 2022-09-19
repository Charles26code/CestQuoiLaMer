import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cestquoilamer/reusable_widgets/widget_general.dart';
import 'package:provider/provider.dart';
import 'package:cestquoilamer/models/user_provider.dart';
import 'package:cestquoilamer/models/user_model.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? mailusername;
  String? mdp;
  String? confirmmdp;

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      if (mdp != confirmmdp) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text("Les mots de passes de correspondent pas."),
            ),
          );
      } else {
        try {
          Map? result = await Provider.of<UserProvider>(
            context,
            listen: false,
          ).changePassword(mailusername, mdp);
          if (result != null) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(result['message']),
                ),
              );
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoSection(),
                  MailSection(
                    mailcallback: (value) => mailusername = value,
                    mdpcallback: (value) => mdp = value,
                    confirmmdpcallback: (value) => confirmmdp = value,
                    submitcallback: () => submitForm(),
                  ),
                ],
              ),
            )
          ],
        ),
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

class MailSection extends StatelessWidget {
  final void Function(String?)? mailcallback;
  final void Function(String?)? mdpcallback;
  final void Function(String?)? confirmmdpcallback;
  final void Function()? submitcallback;

  const MailSection(
      {Key? key,
      required this.mailcallback,
      required this.submitcallback,
      required this.mdpcallback,
      required this.confirmmdpcallback})
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
          champsTextes("Mot de passe", Icons.lock_outlined, true, mdpcallback,
              (value) {
            if (value == null || value.isEmpty) {
              return "Renseignez un mot de passe";
            }
            if (value.length < 8) {
              return "Le mot de passe doit contenir au moin 8 caractères.";
            }
            return null;
          }),
          const SizedBox(
            height: 20,
          ),
          champsTextes("Confirmer le mot de passe", Icons.lock_outlined, true,
              confirmmdpcallback, (value) {
            if (value == null || value.isEmpty) {
              return "Renseignez un mot de passe.";
            }
            if (value.length < 8) {
              return "Le mot de passe doit contenir au moin 8 caractères.";
            }
            return null;
          }),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 450),
            child: SizedBox(
              width: 325,
              child: FloatingActionButton.extended(
                backgroundColor: const Color.fromRGBO(254, 183, 1, 1),
                hoverColor: const Color.fromRGBO(254, 183, 1, 1),
                onPressed: submitcallback,
                label: const Text(
                  'CHANGER MON MOT DE PASSE',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
