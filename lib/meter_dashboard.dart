import 'package:flutter/material.dart';
import 'firebase_service.dart';

class MeterDashboardScreen extends StatefulWidget {
  const MeterDashboardScreen({Key? key}) : super(key: key);

  @override
  _MeterDashboardScreenState createState() => _MeterDashboardScreenState();
}

class _MeterDashboardScreenState extends State<MeterDashboardScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  String temperature = '...';
  String humidity = '...';
  double soilMoisture = 0.00;
  String message = 'Loading...';

  @override
  void initState() {
    super.initState();
    _firebaseService.getMeterData().listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value;
        setState(() {
          temperature = data['Temperature'] ?? 'x';
          humidity = data['Humidity'] ?? 'x';
          soilMoisture = data['SoilMoisture'] ?? 0.00;
          message = data['Message'] ?? 'Loading Error!';
        });
      }
    }, onError: (error) {
      // Handle Firebase errors here, e.g., print error message
      print('Firebase Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text(
          'Sensor Dashboard',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MeterCard(
                title: 'Temperature',
                value: temperature,
                icon: Icons.thermostat_outlined,
                icolor: Colors.redAccent,
              ),
              MeterCard(
                title: 'Humidity',
                value: humidity,
                icon: Icons.water_damage,
                icolor: Colors.blueAccent,
              ),
              MeterCard(
                title: 'Soil Moisture',
                value: soilMoisture.toString(),
                icon: Icons.waves,
                icolor: Colors.brown,
              ),
            ],
          ),
          const SizedBox(height: 40),
    
          showImage(),
          const SizedBox(height: 10), 
          showImagerain(),
          Text(
            message,
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  
   Widget showImage(){
    if (message == 'Not Raining!') {
      if(soilMoisture < 45){
        return Column(
        children: [
          Image.asset(
              'assets/images/shovel.png', 
              width: 150,
              height: 150,
            ),
          const SizedBox(height: 10), 
          Text(
            'Need to fertilize',
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      );
      }else {
       return Column(
        children: [
          Image.asset(
              'assets/images/tree.png', 
              width: 200,
              height: 200,
            ),
          Text(
            'No need to fertilize',
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      );
      }
    }else{
     return Column(
        children: [
          Image.asset(
              'assets/images/tree.png', 
              width: 200,
              height: 200,
            ),
          Text(
            'No need to fertilize',
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      );
    }
    return Container();
  }

   Widget showImagerain(){
    if (message == 'Not Raining!') {
      return Image.asset(
          'assets/icons/03d.png', 
          width: 200,
          height: 200,
        );
    }else{
      return Image.asset(
          'assets/icons/09n.png', 
          width: 200,
          height: 200,
        );
    }
    return Container();
  }
}

class MeterCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color icolor;

  MeterCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.icolor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: icolor),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
