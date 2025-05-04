import 'package:flutter/material.dart';

void main() {
  runApp(const NetflixDownloadApp());
}

class NetflixDownloadApp extends StatelessWidget {
  const NetflixDownloadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const DownloadPage(),
    );
  }
}

class DownloadPage extends StatelessWidget {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Downloads',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Available for Download',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sampleContent.length,
              itemBuilder: (context, index) {
                return DownloadItem(content: sampleContent[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DownloadItem extends StatelessWidget {
  final Map<String, String> content;

  const DownloadItem({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              content['image']!,
              width: 100,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 100,
                height: 60,
                color: Colors.grey[800],
                child: const Icon(Icons.image_not_supported, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content['title']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  content['description']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(
              Icons.download,
              color: Colors.white,
              size: 24,
            ),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Downloading ${content['title']}')),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Sample data for the download list
final List<Map<String, String>> sampleContent = [
  {
    'title': 'Stranger Things',
    'description': 'A group of friends uncover supernatural mysteries in their small town.',
    'image': 'https://images3.alphacoders.com/751/thumb-1920-751563.jpg',
  },
  {
    'title': 'The Witcher',
    'description': 'Geralt of Rivia, a monster hunter, navigates a world of magic and danger.',
    'image': 'https://static1.colliderimages.com/wordpress/wp-content/uploads/2023/06/the-witcher-netflix-poster.jpg',
  },
  {
    'title': 'Breaking Bad',
    'description': 'A chemistry teacher turns to a life of crime to secure his family\'s future.',
    'image': 'https://thaka.bing.com/th/id/OIP.h6ywJUbjhxrDe5kyuwnp6AHaJ4?rs=1&pid=ImgDetMain',
  },
  {
    'title': 'Money Heist',
    'description': 'A criminal mastermind plans the biggest heist in recorded history.',
    'image': 'https://cdna.artstation.com/p/assets/images/images/046/103/336/large/illusion-design-money-heist-poster-min.jpg?1644314844',
  },
  {
    'title': 'The Crown',
    'description': 'The story of Queen Elizabeth II and the political and personal events that shaped her reign.',
    'image': 'https://cdn1.clickthecity.com/images/articles/content/5a0150e57c1ec9.36512137.jpg',
  },
  {
    'title': 'Squid Game',
    'description': 'Contestants in dire financial situations compete in deadly games for a cash prize.',
    'image': 'https://ares.shiftdelete.net/2024/10/squid-game.jpg',
  },
  {
    'title': 'The Umbrella Academy',
    'description': 'A dysfunctional family of adopted sibling superheroes reunite to solve the mystery of their father\'s death.',
    'image': 'https://flxt.tmsimg.com/assets/p16091714_b_v13_aj.jpg',
  },
];