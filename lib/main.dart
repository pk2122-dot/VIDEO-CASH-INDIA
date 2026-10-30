
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const VideoCashIndia());
}

class VideoCashIndia extends StatelessWidget {
  const VideoCashIndia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Cash India',
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

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const ShortsPage(),
      const UploadPage(),
      const WalletPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[selected]),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF191923),
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
    return const Center(
      child: Text(
        'Welcome to Video Cash India',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ShortsPage extends StatelessWidget {
  const ShortsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Short Videos'),
    );
  }
}

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final ImagePicker picker = ImagePicker();

  VideoPlayerController? controller;
  bool loading = false;

  Future<void> selectVideo() async {
    try {
      final XFile? file = await picker.pickVideo(
        source: ImageSource.gallery,
      );

      if (file == null) return;

      setState(() {
        loading = true;
      });

      await controller?.dispose();

      final newController = VideoPlayerController.file(
        File(file.path),
      );

      await newController.initialize();

      if (!mounted) {
        await newController.dispose();
        return;
      }

      setState(() {
        controller = newController;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Video error: $e'),
        ),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_upload_outlined,
              size: 75,
              color: Colors.purpleAccent,
            ),
            const SizedBox(height: 18),
            const Text(
              'Upload Your Video',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text('Share your creativity with the world.'),
            const SizedBox(height: 22),
            ElevatedButton.icon(
              onPressed: loading ? null : selectVideo,
              icon: const Icon(Icons.video_library),
              label: const Text('Select Video'),
            ),
            if (loading) ...[
              const SizedBox(height: 20),
              const CircularProgressIndicator(),
              const Text('Loading video...'),
            ],
            if (controller != null &&
                controller!.value.isInitialized) ...[
              const SizedBox(height: 25),
              AspectRatio(
                aspectRatio: controller!.value.aspectRatio,
                child: VideoPlayer(controller!),
              ),
              const SizedBox(height: 10),
              IconButton(
                iconSize: 45,
                icon: Icon(
                  controller!.value.isPlaying
                      ? Icons.pause_circle
                      : Icons.play_circle,
                ),
                onPressed: () {
                  setState(() {
                    if (controller!.value.isPlaying) {
                      controller!.pause();
                    } else {
                      controller!.play();
                    }
                  });
                },
              ),
              const Text(
                'Video Preview Ready',
                style: TextStyle(color: Colors.greenAccent),
              ),
            ],
          ],
        ),
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
              style: TextStyle(fontSize: 25)),
          SizedBox(height: 12),
          Text('Available Balance'),
          Text('₹ 0.00',
              style: TextStyle(fontSize: 35)),
          SizedBox(height: 10),
          Text('Earnings and withdrawals are not active yet.'),
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
              style: TextStyle(fontSize: 25)),
          Text('Welcome to Video Cash India'),
          SizedBox(height: 10),
          Text('Login and registration coming soon.'),
        ],
      ),
    );
  }
}
