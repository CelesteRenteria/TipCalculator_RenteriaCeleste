import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tip_calculator/screens/home_screen.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConfigurationScreenState();
}

void setDefaultValues(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('percent', value);
    

  }
Future<double?> getDefaultValues() async {
    final prefs = await SharedPreferences.getInstance();
    final double percent = prefs.getDouble('percent') ?? 15;

    return percent;
  }


class _ConfigurationScreenState extends State<ConfigurationScreen> {
final TextEditingController controladorP = TextEditingController();
double tip = 0.0;

  @override
  Widget build(BuildContext context) {
  getDefaultValues().then((value) => {controladorP.text = value.toString()});
  
    return Scaffold(
      appBar: AppBar(title: const Text("Configure Percent"),
      elevation: 0,
      backgroundColor: const Color.fromARGB(251, 235, 150, 31)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
          keyboardType: TextInputType.number,
          controller: controladorP,
          decoration: const InputDecoration(
                  labelText: "Percentage %",
                  labelStyle: TextStyle(color: Color.fromARGB(255, 24, 18, 0)),
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(120, 195, 195, 23))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(251, 235, 150, 31)))),
        ),
        ElevatedButton(onPressed: (){
          double percent = double.parse(controladorP.text);
          Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
          
          setState(() {
                    setDefaultValues(percent);

                  });
        },
        style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(251, 235, 150, 31)), 
        child: const Text("Save Changes"))
          ],
        ),
        
        
      ),
    );
  }
}
