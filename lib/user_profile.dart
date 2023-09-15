import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rubberx/Components/flutter_toast.dart';
import 'package:rubberx/Components/myprovider.dart';
import 'package:rubberx/Login/login_screen.dart';
import 'package:rubberx/weather_dashboard.dart';
import 'package:weather/weather.dart';

class Prediction {
  final DateTime date;
  final List<dynamic> times;
  final double humidity;
  final String rainfall;
  final double temperature;

  Prediction({
    required this.date,
    required this.times,
    required this.humidity,
    required this.rainfall,
    required this.temperature,
  });
}

class Userprofile extends StatefulWidget {
  //final String documentId;

  //IdealTimes({required this.documentId});

  @override
  _UserprofileState createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  WeatherFactory wf = WeatherFactory(
      "6d6fde202290e617a90a412bc2287335"); // Replace with your API key
  Weather? w;

  TextEditingController _amount = TextEditingController();
  TextEditingController time_controller = TextEditingController();
  final TextEditingController humidity_controller = TextEditingController();
  final TextEditingController pressure_controller = TextEditingController();
  final TextEditingController windSpeed_controller = TextEditingController();
  final TextEditingController temperature_controller = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String current_email = 'example@gmail.com';

  void getUser() {
    if (user != null) {
      String? email = user!.email;
      setState(() {
        current_email = email!;
      });
      print("Current user's email: $email");
    }
  }

  void _time_picker() {
    TimeOfDay selectedTime = TimeOfDay.now();
    showTimePicker(
      initialEntryMode: TimePickerEntryMode.inputOnly,
      context: context,
      initialTime: selectedTime,
    ).then((value) {
      setState(() {
        selectedTime = value!;
        time_controller.text = selectedTime.format(context).toString();
      });
    });
  }

  void addModuleData() async {
    DateTime current_date = DateTime.now();

    log("Humidity: ${humidity_controller.text}");
    log("Pressure: ${pressure_controller.text}");
    log("Wind Speed: ${windSpeed_controller.text}");
    log("Temperature: ${w?.temperature.toString().replaceAll("Celsius", "")}");
    log("Time: ${time_controller.text}");
    log("Date: ${current_date.toString()}");
    log("Amount: ${_amount.text}");
    try {
      final module1 = Module(
        amount: _amount.text,
        date: current_date.toString(),
        time: time_controller.text,
        windSpeed: windSpeed_controller.text,
        pressure: pressure_controller.text,
        humidity: humidity_controller.text,
        temperature: w!.temperature.toString().replaceAll("Celsius", ""),
      );

      // Add the modules to Firestore
      await firestoreInstance.collection("user_data").add(module1.toJson());

      AppToastmsg.appToastMeassage('New added successfully.');
    } catch (e) {
      print('error');
      AppToastmsg.appToastMeassage('Error adding module data: $e');
    }
  }

  @override
  void initState() {
    String myLocation =
        Provider.of<MyProvider>(context, listen: false).myLocation;
    super.initState();
    getWeather(myLocation);
    getUser();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> getWeather(String location) async {
    try {
      w = await wf.currentWeatherByCityName(location);
      setState(() {
        humidity_controller.text = '${w?.humidity?.toStringAsFixed(0)}' ?? '';
        pressure_controller.text = '${w?.pressure?.toStringAsFixed(0)}' ?? '';
        windSpeed_controller.text = '${w?.windSpeed?.toStringAsFixed(0)}' ?? '';
      });
    } catch (e) {
      print('Invalid Location');
    }
    setState(() {}); // Update the state to trigger a rebuild
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //print(myLocation);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text(
          'USER PROFILE',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.deepPurple,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1518333648466-e7e0bb965e70?w=1280&h=720',
                      width: 65,
                      height: 65,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(current_email,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text('Humidity (hPa)',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                  TextField(
                    controller: humidity_controller,
                    readOnly: true,
                    style: const TextStyle(color: Colors.white),
                    //controller: pressure,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 18),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                        hintText: '${w?.humidity?.toStringAsFixed(0)}hPa' ?? '',
                        hintStyle: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text('Pressure (P)',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                  TextField(
                    controller: pressure_controller,
                    readOnly: true,
                    style: const TextStyle(color: Colors.white),
                    //controller: pressure,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 18),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                        hintText: '${w?.pressure?.toStringAsFixed(0)}P' ?? '',
                        hintStyle: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text('Wind Speed (kmh)',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                  TextField(
                    controller: windSpeed_controller,
                    readOnly: true,
                    style: const TextStyle(color: Colors.white),
                    //controller: pressure,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 18),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                        hintText:
                            '${w?.windSpeed?.toStringAsFixed(0)}kmh' ?? '',
                        hintStyle: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text('Temperature (C)',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                  TextField(
                    controller: temperature_controller,
                    readOnly: true,
                    style: const TextStyle(color: Colors.white),
                    //controller: pressure,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 18),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                        hintText:
                            '${w?.temperature.toString().replaceAll("Celsius", "")}' ??
                                '',
                        hintStyle: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text('Time',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: time_controller,
                    readOnly: true,
                    onTap: _time_picker,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      ),
                      hintText: 'time',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text('Amount',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _amount,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      ),
                      hintText: 'amount',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(29)),
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                child: TextButton(
                  onPressed: () {
                    addModuleData();
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              IconButton(
                  onPressed: () {
                    signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Loginscreen()));
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.red,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

extension ModuleExtension on Module {
  Map<String, dynamic> toJson() {
    return {
      "time": time,
      "date": date,
      "amount": amount,
      "humidity": humidity,
      "pressure": pressure,
      "windSpeed": windSpeed,
      "temperature": temperature,
    };
  }
}

class Module {
  final String amount;
  final String time;
  final String date;
  final String humidity;
  final String pressure;
  final String windSpeed;
  final String temperature;

  Module({
    required this.amount,
    required this.date,
    required this.time,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.temperature,
  });
}
