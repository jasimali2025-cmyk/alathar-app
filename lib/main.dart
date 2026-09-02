import 'package:flutter/material.dart';

void main() {
  runApp(const AlAtharApp());
}

class AlAtharApp extends StatelessWidget {
  const AlAtharApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'الأثر',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F6FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B6FA4),
          brightness: Brightness.light,
        ),
        fontFamilyFallback: const ['Arial'],
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<_QuickAction> actions = const [
    _QuickAction('مطالعة', Icons.menu_book_outlined),
    _QuickAction('تحميل', Icons.download_for_offline_outlined),
    _QuickAction('إشارات', Icons.bookmark_add_outlined),
    _QuickAction('تعليقات', Icons.edit_note_outlined),
    _QuickAction('اسأل', Icons.lightbulb_outline),
    _QuickAction('انشر', Icons.share_outlined),
  ];

  final List<_BookItem> books = const [
    _BookItem(
      title: 'عبر من واقعة الطف',
      author: 'عبد الغفار محسن',
      subtitle: 'دروس وعبر من نهضة الإمام الحسين عليه السلام',
      icon: Icons.auto_stories_outlined,
    ),
    _BookItem(
      title: 'المعاد وحقيقة الإنسان',
      author: 'مكتبة الأثر',
      subtitle: 'قراءات في حقيقة الإنسان والمعاد',
      icon: Icons.menu_book_outlined,
    ),
    _BookItem(
      title: 'ضرورة المعرفة الدينية',
      author: 'مكتبة الأثر',
      subtitle: 'مدخل إلى المعرفة والفكر الديني',
      icon: Icons.library_books_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 78,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        titleSpacing: 12,
        leadingWidth: 72,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            'assets/alathar-logo.png',
            fit: BoxFit.contain,
          ),
        ),
        title: const Text(
          'الأثر',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Color(0xFF145E83),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              size: 34,
              color: Color(0xFF145E83),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 26, 18, 24),
          children: [
            const SizedBox(height: 28),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: actions.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.95,
              ),
              itemBuilder: (context, index) {
                return _ActionCard(action: actions[index]);
              },
            ),
            const SizedBox(height: 34),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'أحدث الكتب',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF202124),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'عرض الكل',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF1594D2),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 315,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: books.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  return _BookCard(book: books[index], index: index);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 76,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE3F2FA),
        selectedIndex: currentIndex,
        onDestinationSelected: (value) {
          setState(() => currentIndex = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'المكتبة',
          ),
          NavigationDestination(
            icon: Icon(Icons.article_outlined),
            selectedIcon: Icon(Icons.article),
            label: 'المقالات',
          ),
          NavigationDestination(
            icon: Icon(Icons.question_answer_outlined),
            selectedIcon: Icon(Icons.question_answer),
            label: 'الأسئلة',
          ),
          NavigationDestination(
            icon: Icon(Icons.image_outlined),
            selectedIcon: Icon(Icons.image),
            label: 'الصور',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            selectedIcon: Icon(Icons.bookmark),
            label: 'المفضلة',
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final _QuickAction action;

  const _ActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 1.5,
      shadowColor: Colors.black12,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                action.icon,
                size: 44,
                color: const Color(0xFF0E6E9E),
              ),
              const SizedBox(height: 14),
              Text(
                action.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFF145E83),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookCard extends StatelessWidget {
  final _BookItem book;
  final int index;

  const _BookCard({
    required this.book,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final coverColors = [
      const [Color(0xFF1A7BA8), Color(0xFF7EC6DF)],
      const [Color(0xFF766957), Color(0xFFC9B89D)],
      const [Color(0xFF23689B), Color(0xFFB8DFF2)],
    ];

    final colors = coverColors[index % coverColors.length];

    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: colors,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 8,
                  offset: Offset(0, 4),
                  color: Colors.black12,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(book.icon, size: 62, color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    book.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            book.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Color(0xFF202124),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            book.author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF7A7D82),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAction {
  final String title;
  final IconData icon;

  const _QuickAction(this.title, this.icon);
}

class _BookItem {
  final String title;
  final String author;
  final String subtitle;
  final IconData icon;

  const _BookItem({
    required this.title,
    required this.author,
    required this.subtitle,
    required this.icon,
  });
}
