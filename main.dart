import 'package:flutter/material.dart';

void main() => runApp(const CinemaWorldApp());

const gold = Color(0xFFE5B85C);
const bg = Color(0xFF090B10);
const panel = Color(0xFF151923);

class Movie {
  final String title, genre, language, year, rating, emoji;
  final Color color;
  const Movie(this.title, this.genre, this.language, this.year, this.rating,
      this.emoji, this.color);
}

const movies = [
  Movie('Shadow Protocol', 'Action', 'Hindi', '2026', '8.4', '🕶️', Color(0xFF263C58)),
  Movie('The Last Whisper', 'Horror', 'Hindi Dubbed', '2026', '7.9', '👻', Color(0xFF493044)),
  Movie('Beyond the Ocean', 'Adventure', 'English', '2025', '8.1', '🌊', Color(0xFF24505B)),
  Movie('Midnight Promise', 'Romance', 'Hindi', '2025', '7.6', '🌙', Color(0xFF573A58)),
  Movie('Crimson Case', 'Thriller', 'Hindi Dubbed', '2026', '8.0', '🩸', Color(0xFF5A3030)),
  Movie('Laugh Again', 'Comedy', 'English', '2025', '7.3', '😂', Color(0xFF66502D)),
];

class CinemaWorldApp extends StatelessWidget {
  const CinemaWorldApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Cinema World',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme.fromSeed(seedColor: gold, brightness: Brightness.dark),
      useMaterial3: true,
    ),
    home: const HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  String category = 'All';
  String query = '';
  final categories = ['All', 'Action', 'Horror', 'Thriller', 'Romance', 'Comedy', 'Adventure'];

  List<Movie> get filtered => movies.where((m) {
    final matchesCategory = category == 'All' || m.genre == category;
    final matchesQuery = m.title.toLowerCase().contains(query.toLowerCase());
    return matchesCategory && matchesQuery;
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        title: const Row(children: [
          Icon(Icons.movie_filter_rounded, color: gold, size: 27),
          SizedBox(width: 9),
          Text('CINEMA', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.4)),
          SizedBox(width: 5),
          Text('WORLD', style: TextStyle(color: gold, fontWeight: FontWeight.w900, letterSpacing: 1.4)),
        ]),
        actions: [
          IconButton(onPressed: () => setState(() => tab = 1),
            icon: const Icon(Icons.search_rounded)),
          IconButton(onPressed: () => _message('Notifications will be connected in a later step.'),
            icon: const Icon(Icons.notifications_none_rounded)),
        ],
      ),
      body: tab == 2 ? _watchlist() : tab == 1 ? _searchPage() : _home(),
      bottomNavigationBar: NavigationBar(
        backgroundColor: panel,
        indicatorColor: gold.withOpacity(.18),
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.bookmark_border), selectedIcon: Icon(Icons.bookmark), label: 'My List'),
        ],
      ),
    );
  }

  Widget _home() => ListView(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
    children: [
      _hero(),
      const SizedBox(height: 24),
      _sectionTitle('Browse Categories', 'Explore'),
      const SizedBox(height: 12),
      SizedBox(height: 42, child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) => ChoiceChip(
          label: Text(categories[i]),
          selected: category == categories[i],
          onSelected: (_) => setState(() => category = categories[i]),
          selectedColor: gold,
          labelStyle: TextStyle(color: category == categories[i] ? Colors.black : Colors.white),
          side: BorderSide(color: category == categories[i] ? gold : Colors.white24),
        ),
      )),
      const SizedBox(height: 24),
      _sectionTitle('Latest Movies', 'Updated catalogue'),
      const SizedBox(height: 12),
      if (filtered.isEmpty) const Text('No matching movies found.'),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: filtered.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: .67, crossAxisSpacing: 12, mainAxisSpacing: 14),
        itemBuilder: (_, i) => _movieCard(filtered[i]),
      ),
      const SizedBox(height: 20),
      _sectionTitle('Hindi Dubbed', 'Audio filter preview'),
      const SizedBox(height: 12),
      ...movies.where((m) => m.language.toLowerCase().contains('hindi')).take(2).map(_compactMovie),
      const SizedBox(height: 20),
      _sectionTitle('18+ Age-restricted', 'Mainstream titles only'),
      const SizedBox(height: 8),
      const Text('Age-restricted mainstream films will appear here after verified ratings and age-gating are connected.',
        style: TextStyle(color: Colors.white60, height: 1.4)),
    ],
  );

  Widget _hero() => Container(
    height: 205,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      gradient: const LinearGradient(colors: [Color(0xFF49351D), Color(0xFF171B27), Color(0xFF10131B)],
        begin: Alignment.topLeft, end: Alignment.bottomRight),
      border: Border.all(color: gold.withOpacity(.35)),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
      const Text('YOUR WORLD OF MOVIES', style: TextStyle(color: gold, letterSpacing: 2, fontSize: 11, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Text('Every story.\nOne destination.', style: TextStyle(fontSize: 27, height: 1.05, fontWeight: FontWeight.w900)),
      const SizedBox(height: 13),
      FilledButton.icon(
        style: FilledButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black),
        onPressed: () => _message('Movie playback will be enabled when a licensed streaming provider is connected.'),
        icon: const Icon(Icons.play_arrow), label: const Text('Explore Movies')),
    ]),
  );

  Widget _sectionTitle(String title, String subtitle) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
      Text(subtitle, style: const TextStyle(fontSize: 10, color: gold)),
    ],
  );

  Widget _movieCard(Movie m) => InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: () => _details(m),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [m.color, const Color(0xFF11141D)]),
        ),
        child: Stack(children: [
          Center(child: Text(m.emoji, style: const TextStyle(fontSize: 64))),
          Positioned(left: 8, top: 8, child: _tag(m.year)),
          Positioned(right: 8, top: 8, child: _tag('★ ${m.rating}')),
          const Positioned(bottom: 8, right: 8, child: Icon(Icons.play_circle_fill, color: gold, size: 29)),
        ]),
      )),
      const SizedBox(height: 7),
      Text(m.title, maxLines: 1, overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold)),
      Text('${m.genre} • ${m.language}', maxLines: 1, overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 11, color: Colors.white60)),
    ]),
  );

  Widget _tag(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
    decoration: BoxDecoration(color: Colors.black.withOpacity(.65), borderRadius: BorderRadius.circular(7)),
    child: Text(text, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
  );

  Widget _compactMovie(Movie m) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Container(width: 48, height: 58, alignment: Alignment.center,
      decoration: BoxDecoration(color: m.color, borderRadius: BorderRadius.circular(9)),
      child: Text(m.emoji, style: const TextStyle(fontSize: 25))),
    title: Text(m.title, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text('${m.year} • ${m.language}'),
    trailing: const Icon(Icons.chevron_right),
    onTap: () => _details(m),
  );

  Widget _searchPage() => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(children: [
      TextField(
        onChanged: (v) => setState(() { query = v; category = 'All'; }),
        decoration: InputDecoration(
          hintText: 'Search movies...',
          prefixIcon: const Icon(Icons.search),
          filled: true, fillColor: panel,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        ),
      ),
      const SizedBox(height: 18),
      Expanded(child: GridView.builder(
        itemCount: filtered.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: .67, crossAxisSpacing: 12, mainAxisSpacing: 14),
        itemBuilder: (_, i) => _movieCard(filtered[i]),
      )),
    ]),
  );

  Widget _watchlist() => const Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.bookmark_border, size: 54, color: gold),
      SizedBox(height: 12),
      Text('Your watchlist will appear here', style: TextStyle(color: Colors.white70)),
    ]),
  );

  void _details(Movie m) => showModalBottomSheet(
    context: context, backgroundColor: panel, isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (_) => Padding(
      padding: const EdgeInsets.fromLTRB(22, 25, 22, 35),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(child: Container(width: 42, height: 4, decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(5)))),
        const SizedBox(height: 20),
        Text('${m.emoji}  ${m.title}', style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
        const SizedBox(height: 10),
        Text('${m.year} • ${m.genre} • ${m.language} • ★ ${m.rating}', style: const TextStyle(color: gold)),
        const SizedBox(height: 14),
        const Text('Movie information and authorized watching options will be added when the movie database and streaming providers are connected.',
          style: TextStyle(color: Colors.white70, height: 1.5)),
        const SizedBox(height: 18),
        SizedBox(width: double.infinity, child: FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black),
          onPressed: () { Navigator.pop(context); _message('No licensed playback provider is connected in this prototype yet.'); },
          icon: const Icon(Icons.play_arrow), label: const Text('Watch options'))),
      ]),
    ),
  );

  void _message(String text) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
