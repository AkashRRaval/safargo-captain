import 'package:flutter/material.dart';

void main() => runApp(const SafarGoCaptainApp());

const purple = Color(0xFF4D2CDB);
const yellow = Color(0xFFFFB71B);
const green = Color(0xFF20B66B);
const darkBg = Color(0xFF1A1A24);

class SafarGoCaptainApp extends StatelessWidget {
  const SafarGoCaptainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafarGo Captain',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: purple),
        scaffoldBackgroundColor: const Color(0xFFF4F5F9),
        fontFamily: 'Arial',
        useMaterial3: true,
      ),
      home: const CaptainHomeScreen(),
    );
  }
}

class CaptainHomeScreen extends StatefulWidget {
  const CaptainHomeScreen({super.key});

  @override
  State<CaptainHomeScreen> createState() => _CaptainHomeScreenState();
}

class _CaptainHomeScreenState extends State<CaptainHomeScreen> {
  bool isOnline = false;

  void showIncomingRequest() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(22),
        height: 380,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: const Color(0xFFEDE9FF), borderRadius: BorderRadius.circular(12)),
                  child: const Text('NEW RIDE REQUEST', style: TextStyle(color: purple, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                const Text('₹45.00', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: green)),
              ],
            ),
            const SizedBox(height: 16),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(backgroundColor: Color(0xFFEEEEEE), child: Icon(Icons.person, color: Colors.black)),
              title: Text('Rahul Sharma', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text('⭐ 4.9 • Cash Payment'),
            ),
            const Divider(height: 24),
            _locationLine(Icons.my_location, 'Pickup: Maninagar Station', green),
            const SizedBox(height: 10),
            _locationLine(Icons.location_on, 'Drop: Isanpur Circle', Colors.red),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), side: const BorderSide(color: Colors.red)),
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Decline', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: green, padding: const EdgeInsets.symmetric(vertical: 16)),
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ActiveNavigationScreen()));
                    },
                    child: const Text('Accept Ride', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationLine(IconData icon, String text, Color color) => Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15))),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: purple, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.two_wheeler, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 10),
            const Text('SafarGo Captain', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle, size: 28)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isOnline ? const Color(0xFF1B2E23) : darkBg,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isOnline ? "YOU ARE ONLINE" : "YOU ARE OFFLINE",
                      style: TextStyle(color: isOnline ? green : Colors.grey, fontWeight: FontWeight.w800, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isOnline ? "Ready for nearby rides" : "Go online to start earning",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                Switch(
                  value: isOnline,
                  activeColor: green,
                  onChanged: (val) {
                    setState(() => isOnline = val);
                    if (val) {
                      Future.delayed(const Duration(seconds: 2), () {
                        if (mounted && isOnline) showIncomingRequest();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text("Today's Earnings", style: TextStyle(color: Color(0xFF6E6E80), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text("₹ 850.50", style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: purple)),
                  const SizedBox(height: 18),
                  const Divider(),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _StatBox('12', 'Trips Done'),
                      _StatBox('5.2 hrs', 'Online Time'),
                      _StatBox('⭐ 4.9', 'Rating'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E4EC),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Stack(
              children: [
                const Center(child: Icon(Icons.map_outlined, size: 90, color: Color(0x664D2CDB))),
                if (isOnline)
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 70),
                        CircularProgressIndicator(color: purple),
                        SizedBox(height: 8),
                        Text('Searching nearby requests...', style: TextStyle(fontWeight: FontWeight.bold, color: purple)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          if (isOnline)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: yellow, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 14)),
              onPressed: showIncomingRequest,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Simulate Ride Request', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String title;
  final String label;
  const _StatBox(this.title, this.label);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      );
}

class ActiveNavigationScreen extends StatefulWidget {
  const ActiveNavigationScreen({super.key});

  @override
  State<ActiveNavigationScreen> createState() => _ActiveNavigationScreenState();
}

class _ActiveNavigationScreenState extends State<ActiveNavigationScreen> {
  int step = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(step == 2 ? 'On Trip' : 'Going to Pickup', style: const TextStyle(fontWeight: FontWeight.bold))),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color(0xFFE2E4EC),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.navigation, size: 80, color: purple),
                    const SizedBox(height: 12),
                    Text(step == 2 ? 'Navigating to Destination...' : 'Navigating to Pickup Location...', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(child: Icon(Icons.person)),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rahul Sharma', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                        Text('Maninagar Station'),
                      ],
                    ),
                    const Spacer(),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.call, color: purple)),
                  ],
                ),
                const SizedBox(height: 18),
                if (step == 0)
                  FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: purple, minimumSize: const Size.fromHeight(50)),
                    onPressed: () => setState(() => step = 1),
                    child: const Text('Arrived at Pickup', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                if (step == 1)
                  FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: green, minimumSize: const Size.fromHeight(50)),
                    onPressed: () => setState(() => step = 2),
                    child: const Text('Start Trip', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                if (step == 2)
                  FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size.fromHeight(50)),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TripCompleteCaptainScreen()));
                    },
                    child: const Text('Complete Trip (Collect ₹45)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TripCompleteCaptainScreen extends StatelessWidget {
  const TripCompleteCaptainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(radius: 42, backgroundColor: green, child: Icon(Icons.check, size: 48, color: Colors.white)),
              const SizedBox(height: 22),
              const Text('Trip Completed!', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Collect cash payment from rider'),
              const SizedBox(height: 24),
              Card(
                elevation: 0,
                color: Colors.white,
                child: const ListTile(
                  title: Text('Cash to Collect', style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: Text('₹ 45.00', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: green)),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: purple, minimumSize: const Size.fromHeight(50)),
                onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
                child: const Text('Back to Home', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
