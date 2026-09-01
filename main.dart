import 'package:flutter/material.dart';

void main() {
  runApp(const SafarGoApp());
}

class SafarGoApp extends StatelessWidget {
  const SafarGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafarGo Customer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFFA5F6F5),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedVehicle = 'Bike';
  int selectedPrice = 45;

  final TextEditingController pickupController =
      TextEditingController(text: "Current Location (Prahlad Nagar)");
  final TextEditingController dropController =
      TextEditingController(text: "Kalupur Railway Station");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        title: const Text(
          'SafarGo Customer',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background UI / Map Placeholder
          Container(
            color: Colors.grey[200],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.map, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    'Interactive Map View',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Search & Ride Selection Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Location Input Card
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: pickupController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.my_location, color: Colors.green),
                            hintText: 'Pickup Location',
                            border: InputBorder.none,
                          ),
                        ),
                        const Divider(height: 1),
                        TextField(
                          controller: dropController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.location_on, color: Colors.red),
                            hintText: 'Where to go?',
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select Ride Option',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Ride Selection Options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildRideOption('Bike', '₹45', '3 mins away', Icons.directions_bike, 45),
                      _buildRideOption('Auto', '₹80', '5 mins away', Icons.electric_rickshaw, 80),
                      _buildRideOption('Cab', '₹150', '8 mins away', Icons.local_taxi, 150),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Book Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Searching for nearby SafarGo $selectedVehicle Captain...',
                            ),
                            backgroundColor: Colors.black87,
                          ),
                        );
                      },
                      child: Text(
                        'Book SafarGo $selectedVehicle - ₹$selectedPrice',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRideOption(
    String name,
    String price,
    String eta,
    IconData icon,
    int priceVal,
  ) {
    bool isSelected = selectedVehicle == name;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedVehicle = name;
          selectedPrice = priceVal;
        });
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber.withOpacity(0.2) : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.amber : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 36, color: isSelected ? Colors.black : Colors.grey),
            const SizedBox(height: 4),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              price,
              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            Text(
              eta,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
