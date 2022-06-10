import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:tip_calculator/screens/configuration_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  initState(){
    setState(() {
      
    });
    super.initState();

  }
  
  double tip = 0.0;
  String tipvalue = "0.0";

  final TextEditingController controladorA = TextEditingController();
  final TextEditingController controladorP = TextEditingController();

  final _claveFormulario = GlobalKey<FormState>();

  //promesas await y async
  //el await es para que el flujo del programa espere ahí
  void setDefaultValues(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('percent', value);
  }

//para return a value of a asycronus funtionwe use Future
  Future<double?> getDefaultValues() async {
    final prefs = await SharedPreferences.getInstance();
    final double percent = prefs.getDouble('percent') ?? 15;


    return percent;
  }

  @override
  Widget build(BuildContext context) {
    const fontStyle = TextStyle(fontSize: 45);
    getDefaultValues().then((value) => {controladorP.text = value.toString()});
    
    

    return Scaffold(
      appBar: AppBar(
          title: const Text("Tip Calculator"),
          elevation: 0,
          backgroundColor: const Color.fromARGB(251, 235, 150, 31)),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
            const DrawerHeader(
                decoration: BoxDecoration(color: Colors.amber),
                child: Text("Menu",
                    style: TextStyle(color: Colors.white, fontSize: 25))),
            ListTile(
              title: const Text("Configuration"),
              onTap: () {
                final route = MaterialPageRoute(
                    builder: (context) => const ConfigurationScreen());
                Navigator.push(context, route);
                
              },
            )
          ])),
      body: Center(
          child: Form(
        key: _claveFormulario,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Write the Amount';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              controller: controladorA,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                  labelText: "Amount ",
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 24, 18, 0)),
                  border: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(120, 195, 195, 23))),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(251, 235, 150, 31)))),
            ),
            TextFormField(
              enabled: false,
              
              controller: controladorP,
              decoration: const InputDecoration(
                  labelText: "Percentage %",
                  labelStyle: TextStyle(color: Color.fromARGB(255, 24, 18, 0)),
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(120, 195, 195, 23))))
            ),
            ElevatedButton(
                onPressed: () {
                  if (!_claveFormulario.currentState!.validate()) {
                    return;
                  }
                  //String textoA = controladorA.text;
                  //String textoP = controladorP.text;
                  double amount = double.parse(controladorA.text);
                  double percent = double.parse(controladorP.text);

                  tip = amount * (percent / 100);
                  tipvalue = tip.toStringAsFixed(2);
                  
                  print(tipvalue);
                  setState(() {
                  });
                },
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(251, 235, 150, 31)),
                child: const Text("Calculate Tip")),
            Text("Tip to pay \$$tipvalue", style: fontStyle,textAlign: TextAlign.center,)
          ],
        ),
      )),
    );
  }
}
