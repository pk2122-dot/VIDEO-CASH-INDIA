import 'package:flutter/material.dart';

void main() {
  runApp(const VideoCashIndia());
}

class VideoCashIndia extends StatelessWidget {
  const VideoCashIndia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VideoCash India',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF101018),
        colorScheme: const ColorScheme.dark(
          primary: Colors.purpleAccent,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selected = 0;

  final pages = const [
    HomePage(),
    ShortsPage(),
    UploadPage(),
    WalletPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[selected]),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF191923),
        indicatorColor: Colors.purple.withOpacity(0.3),
        selectedIndex: selected,
        onDestinationSelected: (index) {
          setState(() => selected = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.play_circle_outline),
            label: 'Shorts',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: 'Upload',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Wallet',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'VideoCash India',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Colors.purpleAccent,
          ),
        ),
        const SizedBox(height: 6),
        const Text('Watch • Create • Earn'),
        const SizedBox(height: 20),
        const Text(
          'Discover Videos',
          style: TextStyle(fontSize: 21,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        videoCard('Welcome to VideoCash India', 'Creator 1'),
        videoCard('Entertainment & Fun', 'Creator 2'),
        videoCard('Explore the World', 'Creator 3'),
        videoCard('Learn Something New', 'Creator 4'),
      ],
    );
  }

  Widget videoCard(String title, String creator) {
    return Card(
      color: const Color(0xFF20202C),
      margin: const EdgeInsets.only(bottom: 18),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 190,
            width: double.infinity,
            color: const Color(0xFF33264A),
            child: const Icon(
              Icons.play_circle_fill,
              size: 75,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 5),
                Text(creator,
                    style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.favorite_border, size: 19),
                    SizedBox(width: 6),
                    Text('Like'),
                    SizedBox(width: 22),
                    Icon(Icons.visibility_outlined, size: 19),
                    SizedBox(width: 6),
                    Text('Views'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShortsPage extends StatelessWidget {
  const ShortsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.video_library, size: 65,
              color: Colors.purpleAccent),
          SizedBox(height: 15),
          Text('Short Videos',
              style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.bold)),
          Text('Your short video feed will appear here.'),
        ],
      ),
    );
  }
}

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_upload_outlined,
              size: 75, color: Colors.purpleAccent),
          const SizedBox(height: 18),
          const Text('Upload Your Video',
              style: TextStyle(fontSize: 23,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('Share your creativity with the world.'),
          const SizedBox(height: 22),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Video upload will be enabled in a future update.',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Select Video'),
          ),
        ],
      ),
    );
  }
}

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_balance_wallet,
              size: 65, color: Colors.purpleAccent),
          SizedBox(height: 15),
          Text('My Wallet',
              style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text('Available Balance'),
          Text('₹ 0.00',
              style: TextStyle(fontSize: 35,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('Real earnings and withdrawals are not active yet.'),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 42,
            child: Icon(Icons.person, size: 48),
          ),
          SizedBox(height: 15),
          Text('My Profile',
              style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.bold)),
          Text('Welcome to VideoCash India'),
          SizedBox(height: 10),
          Text('Login and registration coming soon.'),
        ],
      ),
    );
  }
}
