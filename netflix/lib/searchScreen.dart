import 'package:flutter/material.dart';


class NetflixSearchApp extends StatelessWidget {
  const NetflixSearchApp({super.key});

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
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white, fontFamily: 'Helvetica'),
        ),
      ),
      home: const SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredContent = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterContent);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterContent() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      isSearching = query.isNotEmpty;
      filteredContent = sampleContent.where((content) {
        return content['title']!.toLowerCase().contains(query) ||
            content['description']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Search',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                hintText: 'TV shows, movies and more',
                hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.mic, color: Colors.white),
                  onPressed: () {
                    // Microphone functionality (not implemented)
                  },
                ),
                filled: true,
                fillColor: const Color(0xFF333333),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
          ),
          Expanded(
            child: isSearching
                ? filteredContent.isEmpty
                    ? const Center(
                        child: Text(
                          'No results found',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 6.0,
                          mainAxisSpacing: 6.0,
                          childAspectRatio: 9 / 16,
                        ),
                        itemCount: filteredContent.length,
                        itemBuilder: (context, index) {
                          return SearchResultItem(content: filteredContent[index]);
                        },
                      )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        const Text(
                          'Top Searches',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: ListView.builder(
                            itemCount: sampleContent.length,
                            itemBuilder: (context, index) {
                              return TopSearchItem(content: sampleContent[index]);
                            },
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
}

class SearchResultItem extends StatelessWidget {
  final Map<String, String> content;

  const SearchResultItem({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to content details (not implemented)
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.network(
                content['image']!,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[800],
                  child: const Icon(Icons.image_not_supported, color: Colors.white),
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[800],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(4.0),
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  content['title']!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopSearchItem extends StatelessWidget {
  final Map<String, String> content;

  const TopSearchItem({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: GestureDetector(
        onTap: () {
          // Navigate to content details (not implemented)
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.network(
                content['image']!,
                width: 80,
                height: 45,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 45,
                  color: Colors.grey[800],
                  child: const Icon(Icons.image_not_supported, color: Colors.white),
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 80,
                    height: 45,
                    color: Colors.grey[800],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                content['title']!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.play_circle_outline,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

// Sample data for the search results
final List<Map<String, String>> sampleContent = [
  {
    'title': 'Stranger Things',
    'description': 'A group of friends uncover supernatural mysteries in their small town.',
    'image': 'https://pics.filmaffinity.com/Stranger_Things_TV_Series-875025085-large.jpg',
  },
  {
    'title': 'The Witcher',
    'description': 'Geralt of Rivia, a monster hunter, navigates a world of magic and danger.',
    'image': 'https://static1.colliderimages.com/wordpress/wp-content/uploads/2023/06/the-witcher-netflix-poster.jpg',
  },
  {
    'title': 'Breaking Bad',
    'description': 'A chemistry teacher turns to a life of crime to secure his family\'s future.',
    'image': 'https://es.web.img3.acsta.net/pictures/18/04/04/22/52/3191575.jpg',
  },
  {
    'title': 'The Crown',
    'description': 'The reign of Queen Elizabeth II and major historical events.',
    'image': 'https://mlpnk72yciwc.i.optimole.com/cqhiHLc.IIZS~2ef73/w:auto/h:auto/q:75/https://bleedingcool.com/wp-content/uploads/2023/12/AAAAQQhkjpzGrfygxwpfta5GyBFv1l4K5x4CAsiKhDaRgJGXlJxTKs8x_TXogsZNeTIgOrTgKLy8nOspzHBfz2R4-XIm0mK_Xhx-9nP23-TvAXlI3f4qw8oxampfJ8gBHn3UQFtB9908zScnjPWZ5E8OXbvO.jpg',
  },
  {
    'title': 'Squid Game',
    'description': 'Contestants risk their lives in deadly children\'s games for a cash prize.',
    'image': 'https://images.hdqwalls.com/download/squid-game-season-2-fl-1680x1050.jpg',
  },
];