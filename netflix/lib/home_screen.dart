import 'package:flutter/material.dart';
import 'package:netflix/video_player.dart';

class NetflixHomePage extends StatefulWidget {
  const NetflixHomePage({super.key});

  @override
  State<NetflixHomePage> createState() => _NetflixHomePageState();
}

class _NetflixHomePageState extends State<NetflixHomePage> {
  final ScrollController _scrollController = ScrollController();

  final List<Movie> featuredContent = [
    Movie(
      title: 'Stranger Things',
      imageUrl:
          'https://www.frogx3.com/wp-content/uploads/2017/10/Stranger-Things-Netflix-Poster.jpg',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      description:
          'When a young boy vanishes, a small town uncovers a mystery involving secret experiments.',
      year: 2016,
      maturityRating: 'TV-14',
      seasons: 4,
      genres: ['Sci-Fi', 'Horror', 'Drama'],
      matchPercentage: 98,
    ),
  ];

  final List<ContentRow> contentRows = [
    ContentRow(
      title: 'Popular on Netflix',
      movies: [
        Movie(
          title: 'The Witcher',
          imageUrl:
              'https://image.tmdb.org/t/p/w500/5bFK5d3mVTAvBCXi5NPWH0tYjKl.jpg',
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
          year: 2019,
          maturityRating: 'TV-MA',
          seasons: 2,
          description:
              'Geralt of Rivia, a solitary monster hunter, struggles to find his place in a world where people often prove more wicked than beasts.',
          genres: ['Fantasy', 'Drama', 'Action'],
          matchPercentage: 95,
        ),
        Movie(
          title: 'Squid Game',
          imageUrl:
              'https://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg',
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
          year: 2021,
          maturityRating: 'TV-MA',
          seasons: 1,
          description:
              'Hundreds of cash-strapped players accept a strange invitation to compete in children\'s games—with a high-stakes twist.',
          genres: ['Thriller', 'Drama', 'Survival'],
          matchPercentage: 97,
        ),
        Movie(
          title: 'Breaking Bad',
          imageUrl:
              'https://image.tmdb.org/t/p/w500/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
          year: 2008,
          maturityRating: 'TV-MA',
          seasons: 5,
          description:
              'A high school chemistry teacher diagnosed with inoperable lung cancer turns to manufacturing and selling methamphetamine.',
          genres: ['Crime', 'Drama', 'Thriller'],
          matchPercentage: 99,
        ),
        Movie(
          title: 'The Crown',
          imageUrl:
              'https://th.bing.com/th/id/OIP.iIhNe0guALT-Y7Mb16WFkQHaJQ?rs=1&pid=ImgDetMain',
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
          year: 2016,
          maturityRating: 'TV-MA',
          seasons: 5,
          description:
              'This drama follows the political rivalries and romance of Queen Elizabeth II\'s reign and the events that shaped the second half of the 20th century.',
          genres: ['Drama', 'History'],
          matchPercentage: 93,
        ),
        Movie(
          title: 'Money Heist',
          imageUrl:
              'https://image.tmdb.org/t/p/w500/reEMJA1uzscCbkpeRJeTT2bjqUp.jpg',
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
          year: 2017,
          maturityRating: 'TV-MA',
          seasons: 5,
          description:
              'Eight thieves take hostages and lock themselves in the Royal Mint of Spain as a criminal mastermind manipulates the police to carry out his plan.',
          genres: ['Crime', 'Drama', 'Thriller'],
          matchPercentage: 96,
        ),
        Movie(
          title: 'Dark',
          imageUrl:
              'https://th.bing.com/th/id/OIP.MhDtvcmgPPqzbgNL3HDJ-AHaK-?rs=1&pid=ImgDetMain',
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
          year: 2017,
          maturityRating: 'TV-MA',
          seasons: 3,
          description:
              'A missing child sets four families on a frantic hunt for answers as they unearth a mind-bending mystery that spans three generations.',
          genres: ['Sci-Fi', 'Thriller', 'Mystery'],
          matchPercentage: 94,
        ),
        Movie(
          title: 'The Queen\'s Gambit',
          imageUrl:
              'https://image.tmdb.org/t/p/w500/zU0htwkhNvBQdVSIKB9s6hgVeFK.jpg',
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
          year: 2020,
          maturityRating: 'TV-MA',
          seasons: 1,
          description:
              'In a 1950s orphanage, a young girl reveals an astonishing talent for chess and begins an unlikely journey to stardom while grappling with addiction.',
          genres: ['Drama'],
          matchPercentage: 97,
        ),
      ],
    ),
    ContentRow(
      title: 'Trending Now',
      movies: [
        Movie(
          title: 'Ozark',
          imageUrl:
              'https://image.tmdb.org/t/p/original/niUR6Ob6O61E5Cbik3Qg8jy0NV4.jpg',
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
          year: 2017,
          maturityRating: 'TV-MA',
          seasons: 4,
          description:
              'A financial adviser drags his family from Chicago to the Missouri Ozarks, where he must launder 500 million in five years to appease a drug boss.',
          genres: ['Crime', 'Drama', 'Thriller'],
          matchPercentage: 92,
        ),
        Movie(
          title: 'Peaky Blinders',
          imageUrl:
              'https://image.tmdb.org/t/p/w500/vUUqzWa2LnHIVqkaKVlVGkVcZIW.jpg',
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
          year: 2013,
          maturityRating: 'TV-MA',
          seasons: 6,
          description:
              'A notorious gang in 1919 Birmingham, England, is led by the fierce Tommy Shelby, a crime boss set on moving up in the world no matter the cost.',
          genres: ['Crime', 'Drama'],
          matchPercentage: 95,
        ),
        Movie(
          title: 'Narcos',
          imageUrl:
              'https://th.bing.com/th/id/OIP.TSSJ7jBCNdWEdjCJ--uyuQHaK-?rs=1&pid=ImgDetMain',
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
          year: 2015,
          maturityRating: 'TV-MA',
          seasons: 3,
          description:
              'The true story of Colombia\'s infamously violent and powerful drug cartels fuels this gritty gangster drama series.',
          genres: ['Crime', 'Drama'],
          matchPercentage: 91,
        ),
        Movie(
          title: 'The Mandalorian',
          imageUrl:
              'https://image.tmdb.org/t/p/w500/sWgBv7LV2PRoQgkxwlibdGXKz1S.jpg',
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
          year: 2019,
          maturityRating: 'TV-14',
          seasons: 2,
          description:
              'After the fall of the Galactic Empire, a lone gunfighter makes his way through the lawless outer reaches of the galaxy.',
          genres: ['Sci-Fi', 'Action', 'Adventure'],
          matchPercentage: 94,
        ),
        Movie(
          title: 'Bridgerton',
          imageUrl:
              'https://th.bing.com/th/id/OIP.9dSAJc2iHG5w_PG_uEZPmQHaLH?rs=1&pid=ImgDetMain',
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
          year: 2020,
          maturityRating: 'TV-MA',
          seasons: 2,
          description:
              'The eight close-knit siblings of the Bridgerton family look for love and happiness in London high society.',
          genres: ['Drama', 'Romance'],
          matchPercentage: 90,
        ),
      ],
    ),
    ContentRow(
      title: 'New Releases',
      movies: [
        Movie(
          title: 'Arcane',
          imageUrl:
              'https://image.tmdb.org/t/p/w500/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg',
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
          year: 2021,
          maturityRating: 'TV-14',
          seasons: 1,
          description:
              'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
          genres: ['Animation', 'Action', 'Adventure'],
          matchPercentage: 96,
        ),
        Movie(
          title: 'The Sandman',
          imageUrl:
              'https://image.tmdb.org/t/p/w500/q54qEgagGOYCq5D1903eBVMNkbo.jpg',
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
          year: 2022,
          maturityRating: 'TV-MA',
          seasons: 1,
          description:
              'After years of imprisonment, Morpheus — the King of Dreams — embarks on a journey across worlds to find what was stolen from him and restore his power.',
          genres: ['Fantasy', 'Drama'],
          matchPercentage: 93,
        ),
        Movie(
          title: 'Wednesday',
          imageUrl:
              'https://image.tmdb.org/t/p/w500/jeGtaMwGxPmQN5xM4ClnwPQcNQz.jpg',
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
          year: 2022,
          maturityRating: 'TV-14',
          seasons: 1,
          description:
              'While attending Nevermore Academy, Wednesday Addams attempts to master her emerging psychic ability, thwart a killing spree and solve the mystery.',
          genres: ['Comedy', 'Crime', 'Fantasy'],
          matchPercentage: 95,
        ),
        Movie(
          title: 'House of the Dragon',
          imageUrl:
              'https://image.tmdb.org/t/p/w500/z2yahl2uefxDCl0nogcRBstwruJ.jpg',
          videoUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
          year: 2022,
          maturityRating: 'TV-MA',
          seasons: 1,
          description:
              'The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke.',
          genres: ['Fantasy', 'Drama', 'Action'],
          matchPercentage: 94,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/7/7a/Logonetflix.png',
          height: 40,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeaturedBanner(featuredContent[0]),
            for (var row in contentRows) _buildContentRow(row),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedBanner(Movie movie) {
    return Stack(
      children: [
        Container(
          height: 500,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(movie.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.7),
                Colors.black,
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 60,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (movie.logoUrl != null)
                Image.network(
                  movie.logoUrl!,
                  height: 100,
                ),
              const SizedBox(height: 20),
              Text(
                movie.description,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildActionButton(Icons.play_arrow, 'Play', onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoPlayerScreen(videoUrl: movie.videoUrl),
                      ),
                    );
                  }),
                  const SizedBox(width: 10),
                  _buildActionButton(Icons.info_outline, 'Info',
                      onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContentRow(ContentRow row) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              row.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: row.movies.length,
              itemBuilder: (context, index) {
                final movie = row.movies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoPlayerScreen(videoUrl: movie.videoUrl),
                      ),
                    );
                  },
                  child: Container(
                    width: 120,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              movie.imageUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.grey[800],
                                child: const Center(
                                    child:
                                        Icon(Icons.error, color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label,
      {VoidCallback? onPressed}) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.8),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
    );
  }
}

class Movie {
  final String title;
  final String imageUrl;
  final String videoUrl;
  final String description;
  final String? logoUrl;
  final int year;
  final String maturityRating;
  final int seasons;
  final List<String> genres;
  final int matchPercentage;

  Movie({
    required this.title,
    required this.imageUrl,
    required this.videoUrl,
    required this.description,
    this.logoUrl,
    required this.year,
    required this.maturityRating,
    required this.seasons,
    required this.genres,
    required this.matchPercentage,
  });
}

class ContentRow {
  final String title;
  final List<Movie> movies;

  ContentRow({
    required this.title,
    required this.movies,
  });
}