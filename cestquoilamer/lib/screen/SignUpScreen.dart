import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cestquoilamer/reusable_widgets/widget_general.dart';
import 'package:cestquoilamer/screen/Login.dart';
import 'package:provider/provider.dart';
import 'package:cestquoilamer/models/user_provider.dart';
import 'package:cestquoilamer/models/user_model.dart';
import 'package:email_validator/email_validator.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

//Class déstinée au fonctionnement propre de la page d'inscription
class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? username;
  String? mail;
  String? mdp;
  String? confirmmdp;

  bool test = false;
  late File _image;
  final picker = ImagePicker();

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
          ).addUser(username, mail, mdp);
          if (result != null) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(result['message']),
                ),
              );
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Login()));
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: const Text('YOU',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Koulen',
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            child: const Text('FIT',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromARGB(1000, 0, 232, 51),
                                    fontFamily: 'Koulen',
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            child: RotationTransition(
                              turns: const AlwaysStoppedAnimation(135 / 360),
                              child: SvgPicture.asset(
                                "img/dumbbell.svg",
                                color: const Color.fromARGB(1000, 0, 232, 51),
                                width: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _showSelectionDialog();
                          test = true;
                        },
                        child: Container(
                          height: 150,
                          width: 150,

                          //Si aucune photo selectioné 'img/profil.png' par default sinon mettre l'image prise
                          child: ClipOval(
                            //borderRadius: BorderRadius.circular(100),
                            child: test == false
                                ? Image.asset(
                                    'img/profile.png',
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ),
                          ),

                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 108, 108, 108),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      champsTextes("Nom d'utilisateur", Icons.person_outline,
                          false, (value) => username = value, (value) {
                        if (value == null || value.isEmpty) {
                          return "Renseigner un nom d'utilisateur.";
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      champsTextes("Adresse Mail", Icons.person_outline, false,
                          (value) => mail = value, (value) {
                        if (value == null || value.isEmpty) {
                          return "Renseigner une adresse mail.";
                        }
                        if (!EmailValidator.validate(value)) {
                          return "Le format de l'adresse mail n'est pas valide.";
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      champsTextes("Mot de passe", Icons.lock_outlined, true,
                          (value) => mdp = value, (value) {
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
                      champsTextes(
                          "Confirmer le mot de passe",
                          Icons.lock_outlined,
                          true,
                          (value) => confirmmdp = value, (value) {
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
                      SizedBox(
                        width: 325,
                        child: FloatingActionButton.extended(
                          backgroundColor:
                              const Color.fromARGB(1000, 0, 232, 51),
                          hoverColor: Color.fromARGB(255, 0, 255, 55),
                          onPressed: () => submitForm(),
                          label: const Text(
                            'INSCRIPTION',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'PT Sans',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()))
                              },
                          child: const Text(
                            " J'ai déjà un compte ->",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'PT Sans'),
                          ))
                    ],
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Fonction permettant de gérer la caméra
  Future selectOrTakePhoto(ImageSource imageSource) async {
    //Selectione l'image prise avec la camera ou selectioné dans la galerie. L'argument source indique d'où l'image doit être extraite.
    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No photo was selected or taken');
      }
    });
  }

  //Boite de dialogue permettant soit la prise, soit la selection de photo
  Future _showSelectionDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Photo de profil'),
            actions: <Widget>[
              SimpleDialogOption(
                child: const Text('Depuis la galerie'),
                onPressed: () {
                  selectOrTakePhoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: const Text('Prendre une photo'),
                onPressed: () {
                  selectOrTakePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}

//Classe destinée au fond d'écran
class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: <Widget>[
      Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage('img/bg-signup.jpg'),
            alignment: FractionalOffset.topCenter,
          ),
        ),
      ),
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('img/bg-circle.png'),
            alignment: FractionalOffset.topCenter,
          ),
        ),
      )
    ]);
  }
}
