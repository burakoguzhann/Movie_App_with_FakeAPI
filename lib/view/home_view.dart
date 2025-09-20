import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/providers/movie_providers.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieProviders>(context, listen: false).getMovie();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Content(context));
  }
}

Widget Content(BuildContext context) {
  final _movieProvider = Provider.of<MovieProviders>(context);
  return Stack(
    children: [
      Container(
        color: Colors.blue.withOpacity(0.9),
        height: double.infinity,
        width: double.infinity,
        child: Text('Deneme', style: TextStyle(fontSize: 12)),
      ),
      // Arka planı devam ettiren Container
      Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white.withOpacity(0.9), // Alt alanın rengi ve parlaklığı
      ),
      Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: Color.fromARGB(232, 9, 28, 51), // AppBar ile aynı renk
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(75, 75),
                bottomRight: Radius.elliptical(75, 75),
              ),
            ),
          ),
          // ...alt alanlar...
        ],
      ),
      Padding(
        padding: EdgeInsets.only(top: 70),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            'M O V I E S',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 70,
              fontWeight: FontWeight.bold,
              fontFamily: 'YaziFont',
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 255),
        child: Container(
          // Sabit yükseklik veriyoruz
          width: double.infinity,
          color: Colors.white.withOpacity(0.1),
          child: _movieProvider.movieList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9, // Kartların oranı
                  ),
                  itemCount: _movieProvider.movieList.length,
                  itemBuilder: (context, index) {
                    final _movie = _movieProvider.movieList[index];
                    return Card(
                      color: Colors.white.withOpacity(0.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 120,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                _movie.images.isNotEmpty
                                    ? _movie.images.first
                                    : '',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.file_download_off_outlined),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Container(
                              height: 30,
                              child: Text(
                                _movie.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.6),
                                      blurRadius: 8,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'TrajanPro',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(
                                  232,
                                  9,
                                  28,
                                  51,
                                ).withOpacity(0.9),
                                elevation: 5,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(40),
                                    ),
                                  ),
                                  builder: (context) {
                                    return Stack(
                                      children: [
                                        Container(
                                          height: 500,
                                          width: double.infinity,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(40),
                                            ),
                                            child: Image.network(
                                              _movie.images.isNotEmpty
                                                  ? _movie.images.first
                                                  : '',
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => Icon(
                                                    Icons
                                                        .file_download_off_outlined,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 25,
                                            top: 100,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                               _buildDetailText('Oyuncular', _movie.actors),
                                               _buildDetailText('Tür', _movie.genre),
                                               _buildDetailText('Puan', _movie.imdbRating),
                                               _buildDetailText('Konu', _movie.plot),
                                               _buildDetailText('Yayın', _movie.released),
                                               _buildDetailText('Yazar', _movie.writer),
                                               _buildDetailText('Yıl', _movie.year),
                                               _buildDetailText('Yönetmen', _movie.director),
                                            ],
                                          )
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                'Detayları Göster',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'TrajanPro',
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    ],
  );
}


Widget _buildDetailText(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Text(
      '$label: $value',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 2,
            offset: Offset(3, 3),
          ),
        ],
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
  );
}