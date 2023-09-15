import 'package:flutter/material.dart';
import 'package:rubberx/NewsShoppingChat/chatbot.dart';
import 'package:rubberx/NewsShoppingChat/news_updates.dart';
import 'package:rubberx/NewsShoppingChat/shopping_products.dart';
import 'package:rubberx/harvest_prediction.dart';
import 'package:rubberx/user_profile.dart';
import '../Signup/background.dart';
import '../meter_dashboard.dart';
import '../weather_dashboard.dart';

class WelcomeBody extends StatefulWidget {
  const WelcomeBody({Key? key}) : super(key: key);

  @override
  _WelcomeBodyState createState() => _WelcomeBodyState();
}

class _WelcomeBodyState extends State<WelcomeBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   "Welcome",
            //   style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 36,
            //       fontWeight: FontWeight.bold),
            // ),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: size.height * 0.35,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(29)),
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              child: TextButton(
                onPressed: () {
                  // Navigate to dashboard.dart DashboardScreen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const WeatherDashboardScreen()));
                },
                child: const Text(
                  "WEATHER DASHBOARD",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(29)),
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              child: TextButton(
                onPressed: () {
                  // Navigate to dashboard.dart DashboardScreen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MeterDashboardScreen()));
                },
                child: const Text(
                  "SENSOR DASHBOARD",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(29)),
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              child: TextButton(
                onPressed: () {
                  // Navigate to dashboard.dart DashboardScreen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HarvestPrediction()));
                },
                child: const Text(
                  "HARVEST PREDICTION",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(29)),
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              child: TextButton(
                onPressed: () {
                  // Navigate to dashboard.dart DashboardScreen
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Userprofile()));
                },
                child: const Text(
                  "USER PROFILE",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(29)),
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewsUpdate()));
                },
                child: const Text(
                  "NEWS & UPDATES",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(29)),
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShoppingProducts()));
                },
                child: const Text(
                  "SHOPPING CART",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(29)),
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              child: TextButton(
                onPressed: () {
                  // Navigate to dashboard.dart DashboardScreen
                  //TODO: Add chat bot screen
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ChatBot()));
                },
                child: const Text(
                  "CHAT BOT",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
