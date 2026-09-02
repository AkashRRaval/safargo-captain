import 'package:flutter/material.dart';

void main() => runApp(const SafarGoCaptainApp());

const purple = Color(0xFF4D2CDB);
const yellow = Color(0xFFFFB71B);
const green = Color(0xFF20B66B);
const bg = Color(0xFFF7F7FB);

class SafarGoCaptainApp extends StatelessWidget {
  const SafarGoCaptainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafarGo Captain',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: purple),
        scaffoldBackgroundColor: bg,
        useMaterial3: true,
      ),
      home: const CaptainHome(),
    );
  }
}

class CaptainHome extends StatefulWidget {
  const CaptainHome({super.key});

  @override
  State<CaptainHome> createState() => _CaptainHomeState();
}

class _CaptainHomeState extends State<CaptainHome> {
  bool online = false;
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: const [
            _Logo(),
            SizedBox(width: 10),
            Text('SafarGo Captain', style: TextStyle(fontWeight: FontWeight.w800)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: IndexedStack(
        index: tab,
        children: [
          _dashboard(),
          _trips(),
          _earnings(),
          _profile(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (value) => setState(() => tab = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.route_outlined), selectedIcon: Icon(Icons.route), label: 'Trips'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), selectedIcon: Icon(Icons.account_balance_wallet), label: 'Earnings'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _dashboard() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [purple, Color(0xFF704FE8)]),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Captain dashboard', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    SizedBox(height: 7),
                    Text('₹0 today', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800)),
                    SizedBox(height: 5),
                    Text('Complete rides and grow your earnings', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white.withAlpha(30), shape: BoxShape.circle),
                child: const Icon(Icons.two_wheeler, color: Colors.white, size: 34),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: Row(
            children: [
              Icon(online ? Icons.radio_button_checked : Icons.radio_button_off, color: online ? green : Colors.grey),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(online ? 'You are online' : 'You are offline', style: const TextStyle(fontWeight: FontWeight.w800)),
                    Text(online ? 'Looking for nearby ride requests' : 'Go online to receive ride requests', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Switch(value: online, onChanged: (v) => setState(() => online = v)),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text('Today', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        Row(
          children: [
            _stat('0', 'Rides', Icons.route),
            const SizedBox(width: 12),
            _stat('₹0', 'Earnings', Icons.payments_outlined),
            const SizedBox(width: 12),
            _stat('0', 'Hours', Icons.access_time),
          ],
        ),
        const SizedBox(height: 20),
        if (online) _requestCard() else _tipCard(),
      ],
    );
  }

  Widget _requestCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), boxShadow: const [BoxShadow(blurRadius: 15, color: Color(0x12000000))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: const [Icon(Icons.notifications_active, color: yellow), SizedBox(width: 8), Text('New ride request', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18))]),
          const SizedBox(height: 16),
          const Text('Pickup', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const Text('Maninagar, Ahmedabad', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          const Text('Drop', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const Text('Navrangpura, Ahmedabad', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 14),
          Row(children: const [Icon(Icons.route, size: 18, color: purple), SizedBox(width: 6), Text('6.4 km'), Spacer(), Text('₹118', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800))]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Decline'))),
            const SizedBox(width: 10),
            Expanded(child: FilledButton(onPressed: () {}, style: FilledButton.styleFrom(backgroundColor: purple), child: const Text('Accept'))),
          ]),
        ],
      ),
    );
  }

  Widget _tipCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
      child: const Row(children: [Icon(Icons.lightbulb_outline, color: yellow, size: 30), SizedBox(width: 12), Expanded(child: Text('Go online when you are ready. Nearby ride requests will appear here.'))]),
    );
  }

  Widget _trips() => const _EmptyPage(icon: Icons.route, title: 'Your trips', subtitle: 'Completed rides will appear here.');
  Widget _earnings() => const _EmptyPage(icon: Icons.account_balance_wallet, title: 'Your earnings', subtitle: 'Your daily and weekly earnings will appear here.');
  Widget _profile() => const _EmptyPage(icon: Icons.person, title: 'Captain profile', subtitle: 'Vehicle, documents and account settings.');

  Widget _stat(String value, String label, IconData icon) {
    return Expanded(child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)), child: Column(children: [Icon(icon, color: purple), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)), Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey))])));
  }
}

class _Logo extends StatelessWidget {
  const _Logo();
  @override
  Widget build(BuildContext context) => Container(width: 38, height: 38, decoration: BoxDecoration(gradient: const LinearGradient(colors: [yellow, purple]), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.location_on, color: Colors.white));
}

class _EmptyPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _EmptyPage({required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Center(child: Padding(padding: const EdgeInsets.all(30), child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 64, color: purple), const SizedBox(height: 16), Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)), const SizedBox(height: 8), Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey))])));
}
