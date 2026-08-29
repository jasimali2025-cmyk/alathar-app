
import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(const AlAtharApp());

enum ContentType { book, article, question, reading }

class ContentItem {
  final String id;
  final String title;
  final String subtitle;
  final String body;
  final ContentType type;
  final String category;
  final String? author;

  const ContentItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.type,
    required this.category,
    this.author,
  });
}

const items = <ContentItem>[
  ContentItem(
    id: 'book_1',
    title: 'عبر من واقعة الطف',
    subtitle: 'دروس وعبر من نهضة الإمام الحسين عليه السلام',
    body: 'هذا القسم مخصص لكتاب عبر من واقعة الطف.\n\n'
        'يمكن لاحقًا إدخال الكتاب كاملًا داخل التطبيق أو تقسيمه إلى فصول مستقلة ليسهل على القارئ التنقل بينها.\n\n'
        'فصول مقترحة:\n'
        '• المقدمة\n• الكلمة\n• الهداية\n• الهوى\n• الصبر\n• الظلم\n'
        '• التضحية\n• الإيثار\n• العطاء\n• التوبة\n'
        '• الأمر بالمعروف والنهي عن المنكر\n• المساواة والإنسانية\n• الخاتمة',
    type: ContentType.book,
    category: 'كتب دينية',
    author: 'عبد الغفار محسن',
  ),
  ContentItem(
    id: 'article_1',
    title: 'لماذا يبقى الأثر؟',
    subtitle: 'مقال افتتاحي',
    body: 'يمضي الإنسان، ولكن أثره لا ينتهي بانتهاء أيامه.\n\n'
        'الكلمة الطيبة، والعلم النافع، والموقف الصادق، والكتاب الذي يتركه صاحبه؛ كلها آثار تبقى بعده.\n\n'
        'ومن هنا جاءت فكرة تطبيق الأثر: أن يكون موضعًا يجمع الكتب والمقالات والأسئلة والمطالعات ويحفظ ما يستحق أن يبقى.',
    type: ContentType.article,
    category: 'فكر',
    author: 'عبد الغفار محسن',
  ),
  ContentItem(
    id: 'question_1',
    title: 'ما المقصود بالعبرة من واقعة الطف؟',
    subtitle: 'سؤال وجواب',
    body: 'المقصود بالعبرة هو الانتقال من مجرد قراءة الحدث التاريخي إلى فهم الدرس الذي يمكن أن يغيّر سلوك الإنسان في حياته اليومية.\n\n'
        'فالطف ليست قصة تُروى فقط، بل مدرسة في الهداية والصبر والتضحية والكرامة والإصلاح.',
    type: ContentType.question,
    category: 'أسئلة دينية',
  ),
  ContentItem(
    id: 'reading_1',
    title: 'مطالعة اليوم',
    subtitle: 'يمضي الإنسان ويبقى أثره',
    body: 'لا تُقاس حياة الإنسان بعدد السنين فقط، وإنما بما يتركه من أثر.\n\n'
        'قد يبقى كتاب بعد صاحبه، أو كلمة في قلب إنسان، أو موقف أعاد شخصًا إلى طريق الخير.\n\n'
        'فاجعل في كل يوم أثرًا يستحق أن يبقى.',
    type: ContentType.reading,
    category: 'مطالعة',
  ),
];

class AlAtharApp extends StatefulWidget {
  const AlAtharApp({super.key});

  @override
  State<AlAtharApp> createState() => _AlAtharAppState();
}

class _AlAtharAppState extends State<AlAtharApp> {
  bool darkMode = false;

  ThemeData _theme(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF5E4635),
        brightness: brightness,
      ),
      scaffoldBackgroundColor:
          dark ? const Color(0xFF1C1815) : const Color(0xFFF6F0E6),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: const CardThemeData(elevation: 0),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.w700),
        titleMedium: TextStyle(fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(height: 1.8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'الأثر',
      locale: const Locale('ar'),
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child ?? const SizedBox.shrink(),
      ),
      theme: _theme(Brightness.light),
      darkTheme: _theme(Brightness.dark),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(
        darkMode: darkMode,
        onToggleTheme: () => setState(() => darkMode = !darkMode),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final bool darkMode;
  final VoidCallback onToggleTheme;

  const HomeScreen({
    super.key,
    required this.darkMode,
    required this.onToggleTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final Set<String> favorites = {};

  List<ContentItem> byType(ContentType t) =>
      items.where((e) => e.type == t).toList();

  void toggleFavorite(String id) {
    setState(() {
      favorites.contains(id) ? favorites.remove(id) : favorites.add(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      SectionPage(
        title: 'الكتب',
        subtitle: 'مكتبتك ومؤلفاتك',
        icon: Icons.menu_book_rounded,
        data: byType(ContentType.book),
        favorites: favorites,
        onFavorite: toggleFavorite,
      ),
      SectionPage(
        title: 'المقالات',
        subtitle: 'مقالات فكرية ودينية واجتماعية',
        icon: Icons.article_rounded,
        data: byType(ContentType.article),
        favorites: favorites,
        onFavorite: toggleFavorite,
      ),
      SectionPage(
        title: 'الأسئلة',
        subtitle: 'أسئلة وأجوبة مرتبة حسب الموضوع',
        icon: Icons.question_answer_rounded,
        data: byType(ContentType.question),
        favorites: favorites,
        onFavorite: toggleFavorite,
      ),
      SectionPage(
        title: 'المطالعة',
        subtitle: 'مختارات قصيرة للقراءة اليومية',
        icon: Icons.auto_stories_rounded,
        data: byType(ContentType.reading),
        favorites: favorites,
        onFavorite: toggleFavorite,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AtharLogo(size: 40),
            SizedBox(width: 6),
            Text('الأثر'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'بحث',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            ),
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'favorites') {
                final fav = items.where((e) => favorites.contains(e.id)).toList();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FavoritesScreen(data: fav)),
                );
              } else if (value == 'theme') {
                widget.onToggleTheme();
              } else if (value == 'about') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                );
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'favorites', child: Text('المفضلة')),
              PopupMenuItem(
                value: 'theme',
                child: Text(widget.darkMode ? 'الوضع الفاتح' : 'الوضع الداكن'),
              ),
              const PopupMenuItem(value: 'about', child: Text('عن التطبيق')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (index == 0)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(22),
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                   Image.asset(
  'assets/alathar-logo.png',
  height: 150,
  fit: BoxFit.contain,
),
const SizedBox(height: 12),
                     Text ('يمضي الإنسان... ويبقى أثره',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text('مكتبة شخصية للكتب والفكر والمعرفة'),
                  ],
                ),
              ),
            ),
          Expanded(child: pages[index]),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'الكتب',
          ),
          NavigationDestination(
            icon: Icon(Icons.article_outlined),
            selectedIcon: Icon(Icons.article),
            label: 'المقالات',
          ),
          NavigationDestination(
            icon: Icon(Icons.help_outline),
            selectedIcon: Icon(Icons.help),
            label: 'الأسئلة',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_stories_outlined),
            selectedIcon: Icon(Icons.auto_stories),
            label: 'المطالعة',
          ),
        ],
      ),
    );
  }
}

class SectionPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<ContentItem> data;
  final Set<String> favorites;
  final ValueChanged<String> onFavorite;

  const SectionPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.data,
    required this.favorites,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 28),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                CircleAvatar(radius: 28, child: Icon(icon, size: 30)),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 4),
                      Text(subtitle),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        ...data.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(14),
                leading: CircleAvatar(child: Icon(iconFor(item.type))),
                title: Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(item.subtitle),
                trailing: IconButton(
                  onPressed: () => onFavorite(item.id),
                  icon: Icon(
                    favorites.contains(item.id)
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                  ),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailScreen(item: item)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

IconData iconFor(ContentType type) => switch (type) {
      ContentType.book => Icons.menu_book_rounded,
      ContentType.article => Icons.article_rounded,
      ContentType.question => Icons.question_answer_rounded,
      ContentType.reading => Icons.auto_stories_rounded,
    };

class DetailScreen extends StatelessWidget {
  final ContentItem item;
  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: SelectionArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
          children: [
            if (item.author != null) ...[
              Text('تأليف: ${item.author}'),
              const SizedBox(height: 12),
            ],
            Text(item.subtitle, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 18),
            Text(
              item.body,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 19,
                    height: 1.9,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final q = query.trim().toLowerCase();
    final results = q.isEmpty
        ? items
        : items.where((e) {
            return e.title.toLowerCase().contains(q) ||
                e.subtitle.toLowerCase().contains(q) ||
                e.body.toLowerCase().contains(q) ||
                e.category.toLowerCase().contains(q);
          }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('البحث في الأثر')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              onChanged: (v) => setState(() => query = v),
              decoration: const InputDecoration(
                hintText: 'ابحث في الكتب والمقالات والأسئلة...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, i) {
                  final item = results[i];
                  return ListTile(
                    leading: Icon(iconFor(item.type)),
                    title: Text(item.title),
                    subtitle: Text(item.subtitle),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailScreen(item: item)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  final List<ContentItem> data;
  const FavoritesScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المفضلة')),
      body: data.isEmpty
          ? const Center(child: Text('لم تضف شيئًا إلى المفضلة بعد'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: data.length,
              itemBuilder: (context, i) {
                final item = data[i];
                return ListTile(
                  leading: const Icon(Icons.bookmark),
                  title: Text(item.title),
                  subtitle: Text(item.subtitle),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DetailScreen(item: item)),
                  ),
                );
              },
            ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عن الأثر')),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          const Center(child: AtharLogo(size: 125)),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'الأثر',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 4),
          const Center(child: Text('يمضي الإنسان... ويبقى أثره')),
          const SizedBox(height: 24),
          const Text(
            'تطبيق ثقافي شخصي يضم الكتب والمقالات والأسئلة والمطالعات، ويهدف إلى حفظ النتاج الفكري وتقديمه للقارئ بصورة هادئة وسهلة.',
            style: TextStyle(height: 1.8, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class AtharLogo extends StatelessWidget {
  final double size;
  const AtharLogo({super.key, this.size = 90});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _AtharPainter(
          dark: Theme.of(context).brightness == Brightness.dark,
        ),
      ),
    );
  }
}

class _AtharPainter extends CustomPainter {
  final bool dark;
  _AtharPainter({required this.dark});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = dark ? Colors.white : const Color(0xFF5E4635)
      ..strokeWidth = size.width * .065
      ..strokeCap = StrokeCap.round;

    final cx = size.width * .58;
    final cy = size.height * .30;

    canvas.drawCircle(Offset(cx, cy), size.width * .085, p);
    canvas.drawLine(
      Offset(cx, cy + size.height * .10),
      Offset(cx - size.width * .02, cy + size.height * .31),
      p,
    );
    canvas.drawLine(
      Offset(cx, cy + size.height * .16),
      Offset(cx - size.width * .18, cy + size.height * .27),
      p,
    );
    canvas.drawLine(
      Offset(cx, cy + size.height * .16),
      Offset(cx + size.width * .13, cy + size.height * .23),
      p,
    );
    canvas.drawLine(
      Offset(cx - size.width * .02, cy + size.height * .31),
      Offset(cx - size.width * .16, cy + size.height * .50),
      p,
    );
    canvas.drawLine(
      Offset(cx - size.width * .02, cy + size.height * .31),
      Offset(cx + size.width * .15, cy + size.height * .47),
      p,
    );

    final pts = [
      Offset(size.width * .15, size.height * .76),
      Offset(size.width * .29, size.height * .66),
      Offset(size.width * .41, size.height * .57),
    ];
    for (var i = 0; i < pts.length; i++) {
      final fp = Paint()
        ..color = const Color(0xFFB78B55).withOpacity(.35 + i * .25);
      canvas.save();
      canvas.translate(pts[i].dx, pts[i].dy);
      canvas.rotate(-math.pi / 5);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset.zero,
          width: size.width * .10,
          height: size.height * .055,
        ),
        fp,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _AtharPainter oldDelegate) =>
      oldDelegate.dark != dark;
}
