import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercício 01',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink)),
      home: const GridPage(),
    );
  }
}

class Photo {
  final String url;
  final String title;
  final String subtitle;

  const Photo({required this.url, required this.title, required this.subtitle});
}

const photos = [
  Photo(
    url: 'https://picsum.photos/id/1080/400/400',
    title: 'Chennai',
    subtitle: 'Flower Market',
  ),
  Photo(
    url: 'https://picsum.photos/id/1040/400/400',
    title: 'Tanjore',
    subtitle: 'Bronze Works',
  ),
  Photo(
    url: 'https://picsum.photos/id/292/400/400',
    title: 'Tanjore',
    subtitle: 'Market',
  ),
  Photo(
    url: 'https://picsum.photos/id/1048/400/400',
    title: 'Tanjore',
    subtitle: 'Thanjavur Temple',
  ),
  Photo(
    url: 'https://picsum.photos/id/1029/400/400',
    title: 'Tanjore',
    subtitle: 'Thanjavur Temple',
  ),
  Photo(
    url: 'https://picsum.photos/id/1015/400/400',
    title: 'Pondicherry',
    subtitle: 'Salt Farm',
  ),
  Photo(
    url: 'https://picsum.photos/id/1039/400/400',
    title: 'Chennai',
    subtitle: 'Scooters',
  ),
  Photo(
    url: 'https://picsum.photos/id/1043/400/400',
    title: 'Chettinad',
    subtitle: 'Silk Maker',
  ),
  Photo(
    url: 'https://picsum.photos/id/1047/400/400',
    title: 'Chettinad',
    subtitle: 'Lunch Prep',
  ),
  Photo(
    url: 'https://picsum.photos/id/1067/400/400',
    title: 'Tanjore',
    subtitle: 'Market',
  ),
];

class GridPage extends StatelessWidget {
  const GridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GridView')),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        children: photos.map((photo) => PhotoTile(photo: photo)).toList(),
      ),
    );
  }
}

class PhotoTile extends StatelessWidget {
  final Photo photo;

  const PhotoTile({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(photo.title),
          subtitle: Text(photo.subtitle),
        ),
        child: Image.network(
          photo.url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) => progress == null
              ? child
              : const Center(child: CircularProgressIndicator()),
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey.shade300,
            child: const Icon(Icons.broken_image, size: 48),
          ),
        ),
      ),
    );
  }
}
