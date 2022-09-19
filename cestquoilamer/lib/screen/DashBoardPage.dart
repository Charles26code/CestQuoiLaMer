import 'package:flutter/material.dart';

import 'Login.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromRGBO(254, 183, 1, 1)),
        backgroundColor: Colors.white,
        title: const Text('Sakartone 📦',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Color.fromRGBO(254, 183, 1, 1),
                fontFamily: 'Pacifico',
                fontSize: 40,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: Text(
                "Chiffre d'affaire: 366 000€",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Center(
              child: Text(
                "Cout salarial :",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Center(
              child: Icon(Icons.person),
            ),
            const Center(
                child: Text(
              '236€',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )),
            Center(
                child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.40,
              width: MediaQuery.of(context).size.width * 0.75,
            )),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              child: DrawerHeader(
                child: Stack(
                    alignment: Alignment.center, children: const <Widget>[]),
              ),
            ),

            // Ajout des différents menus dans une liste
            ListTile(
              title: const Text('Dashboard',
                  style: TextStyle(
                      color: Color.fromRGBO(254, 183, 1, 1),
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashBoardPage()));
              },
            ),

            const Divider(
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Color.fromARGB(255, 108, 108, 108),
            ),

            ListTile(
              title: const Text('Carton',
                  style: TextStyle(
                      color: Color.fromRGBO(254, 183, 1, 1),
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const FormulaireCreation()));
              },
            ),
            const Divider(
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Color.fromARGB(255, 108, 108, 108),
            ),
            ListTile(
              title: const Text('Scotch',
                  style: TextStyle(
                      color: Color.fromRGBO(254, 183, 1, 1),
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashBoardPage()));
              },
            ),
            const Divider(
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Color.fromARGB(255, 108, 108, 108),
            ),
            ListTile(
              title: const Text('Support client',
                  style: TextStyle(
                      color: Color.fromRGBO(254, 183, 1, 1),
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashBoardPage()));
              },
            ),

            const Divider(
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Color.fromARGB(255, 108, 108, 108),
            ),
            ListTile(
              title: const Text('Se déconnecter',
                  style: TextStyle(
                      color: Color.fromRGBO(254, 183, 1, 1),
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
