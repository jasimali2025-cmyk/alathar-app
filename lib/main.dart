import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

 Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jnvyddardniyuiqhkrhv.supabase.co',
   anonKey: 'sb_publishable_4Ri0VIeVHlohAL6aRuZ6CA_KdbNVb-j',
  );

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0B6FA4)),
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
  int index = 0;

  final actions = const [
    ('مطالعة', Icons.menu_book_outlined),
    ('تحميل', Icons.download_for_offline_outlined),
    ('إشارات', Icons.bookmark_add_outlined),
    ('تعليقات', Icons.edit_note_outlined),
    ('اسأل', Icons.lightbulb_outline),
    ('انشر', Icons.share_outlined),
  ];

  void openAction(String title, IconData icon) {
    if (title == 'اسأل') {
      setState(() => index = 2);
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Directionality(
          textDirection: TextDirection.rtl,
          child: SimplePage(title: title, icon: icon),
        ),
      ),
    );
  }

  Widget library() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SizedBox(height: 22),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: actions.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: .95,
          ),
          itemBuilder: (_, i) {
            final a = actions[i];
            return Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => openAction(a.$1, a.$2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(a.$2, size: 44, color: const Color(0xFF0E6E9E)),
                    const SizedBox(height: 12),
                    Text(
                      a.$1,
                      style: const TextStyle(
                        fontSize: 19,
                        color: Color(0xFF145E83),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 34),
        Row(
          children: [
            const Expanded(
              child: Text(
                'أحدث الكتب',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Directionality(
                    textDirection: TextDirection.rtl,
                    child: SimplePage(
                      title: 'كل الكتب',
                      icon: Icons.library_books_outlined,
                    ),
                  ),
                ),
              ),
              child: const Text('عرض الكل'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 290,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              bookCard(
                'عبر من واقعة الطف',
                'عبد الغفار محسن',
                Icons.auto_stories_outlined,
              ),
              bookCard(
                'المعاد وحقيقة الإنسان',
                'مكتبة الأثر',
                Icons.menu_book_outlined,
              ),
              bookCard(
                'ضرورة المعرفة الدينية',
                'مكتبة الأثر',
                Icons.library_books_outlined,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget bookCard(String title, String author, IconData icon) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Directionality(
            textDirection: TextDirection.rtl,
            child: BookPage(title: title, author: author, icon: icon),
          ),
        ),
      ),
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 210,
              decoration: BoxDecoration(
                color: const Color(0xFF176F9A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 64, color: Colors.white),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(title, maxLines: 2, style: const TextStyle(fontWeight: FontWeight.w800)),
            Text(author, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget section(String title, IconData icon, List<String> items) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              Icon(icon, size: 46, color: const Color(0xFF0E6E9E)),
              const SizedBox(width: 14),
              Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
            ],
          ),
        ),
        const SizedBox(height: 18),
        ...items.map(
          (e) => Card(
            color: Colors.white,
            elevation: 0,
            child: ListTile(
              leading: Icon(icon, color: const Color(0xFF145E83)),
              title: Text(e),
              trailing: const Icon(Icons.chevron_left),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: SimplePage(title: e, icon: icon),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      library(),
      section('المقالات', Icons.article_outlined, const [
        'لماذا يبقى الأثر؟',
        'الكلمة الطيبة وأثرها',
        'الوعي والمعرفة في حياة الإنسان',
      ]),
      section('الأسئلة', Icons.question_answer_outlined, const [
        'ما المقصود بالعبرة من واقعة الطف؟',
        'كيف نقرأ الحدث التاريخي؟',
        'ما أثر المعرفة في بناء الإنسان؟',
      ]),
      section('الصور', Icons.image_outlined, const [
        'صور الكتب',
        'صور المقالات',
        'بطاقات واقتباسات',
      ]),
      section('المفضلة', Icons.bookmark_outline, const [
        'الكتب المفضلة',
        'المقالات المفضلة',
        'الأسئلة المحفوظة',
      ]),
    ];

    const titles = ['الأثر', 'المقالات', 'الأسئلة', 'الصور', 'المفضلة'];

    return Scaffold(
     floatingActionButton: FloatingActionButton.extended(
 onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const PublishScreen(),
    ),
  );
},
  icon: const Icon(Icons.add),
  label: const Text('نشر جديد'),
),
     
     
      appBar: AppBar(
        toolbarHeight: 78,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leadingWidth: 72,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset('assets/alathar-logo.png', fit: BoxFit.contain),
        ),
        title: Text(
          titles[index],
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Color(0xFF145E83),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, size: 34, color: Color(0xFF145E83)),
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => const Directionality(
                textDirection: TextDirection.rtl,
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.info_outline),
                        title: Text('عن تطبيق الأثر'),
                        subtitle: Text('مكتبة شخصية للكتب والفكر والمعرفة'),
                      ),
                      ListTile(
                        leading: Icon(Icons.person_outline),
                        title: Text('عن المؤلف'),
                        subtitle: Text('عبد الغفار محسن'),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'المكتبة'),
          NavigationDestination(icon: Icon(Icons.article_outlined), label: 'المقالات'),
          NavigationDestination(icon: Icon(Icons.question_answer_outlined), label: 'الأسئلة'),
          NavigationDestination(icon: Icon(Icons.image_outlined), label: 'الصور'),
          NavigationDestination(icon: Icon(Icons.bookmark_border), label: 'المفضلة'),
        ],
      ),
    );
  }
}

class SimplePage extends StatelessWidget {
  final String title;
  final IconData icon;
  const SimplePage({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6FA),
      appBar: AppBar(title: Text(title), backgroundColor: Colors.white),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 70, color: const Color(0xFF0E6E9E)),
              const SizedBox(height: 18),
              Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              const Text(
                'هذه الصفحة أصبحت مرتبطة وتفتح عند الضغط. سنضيف محتواها الكامل في الخطوات القادمة.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, height: 1.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookPage extends StatelessWidget {
  final String title;
  final String author;
  final IconData icon;
  const BookPage({super.key, required this.title, required this.author, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6FA),
      appBar: AppBar(title: Text(title), backgroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: const Color(0xFF145E83),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 82, color: Colors.white),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(author, style: const TextStyle(fontSize: 17, color: Colors.grey)),
          const SizedBox(height: 22),
          FilledButton.icon(
            icon: const Icon(Icons.menu_book),
            label: const Text('ابدأ المطالعة'),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: SimplePage(title: 'مطالعة: $title', icon: Icons.menu_book),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PublishScreen extends StatefulWidget {
  const PublishScreen({super.key});

  @override
  State<PublishScreen> createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
 final emailController = TextEditingController();
final passwordController = TextEditingController();
  String kind = 'article';
 bool isLoading = false;
Future<bool> login() async {
  try {
    await Supabase.instance.client.auth.signInWithPassword(
      email: emailController.text.trim(),
      password: passwordController.text,
    );
    return true;
  } catch (e) {
    return false;
  }
}
 Future<void> publish() async {

 if (titleController.text.trim().isEmpty ||
    bodyController.text.trim().isEmpty) {
  return;
}

setState(() {
  isLoading = true;
});
  try {
  final user = Supabase.instance.client.auth.currentUser;

  if (user == null) {
    final ok = await login();
    if (!ok) {
      setState(() {
        isLoading = false;
      });
      return;
    }
  }

  final currentUser = Supabase.instance.client.auth.currentUser;

  await Supabase.instance.client.from('content_items').insert({
    'kind': kind,
    'title': titleController.text.trim(),
    'body': bodyController.text.trim(),
    'author_name': 'عبد الغفار محسن الركابي',
    'status': 'published',
    'published_at': DateTime.now().toIso8601String(),
    'created_by': currentUser!.id,
  });

  titleController.clear();
  bodyController.clear();

  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم النشر بنجاح')),
    );
  }
} catch (e) {
  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('حدث خطأ أثناء النشر: $e')),
    );
  }
} finally {
  if (mounted) {
    setState(() {
      isLoading = false;
    });
  }
}
  }
  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
   emailController.dispose();
passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('نشر جديد'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
             TextField(
  controller: emailController,
  keyboardType: TextInputType.emailAddress,
  decoration: const InputDecoration(
    labelText: 'البريد الإلكتروني للمؤلف',
    border: OutlineInputBorder(),
  ),
),
const SizedBox(height: 16),
TextField(
  controller: passwordController,
  obscureText: true,
  decoration: const InputDecoration(
    labelText: 'كلمة المرور',
    border: OutlineInputBorder(),
  ),
),
const SizedBox(height: 16), DropdownButtonFormField<String>(
                value: kind,
                decoration: const InputDecoration(
                  labelText: 'نوع المحتوى',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'book', child: Text('كتاب')),
                  DropdownMenuItem(value: 'article', child: Text('مقال')),
                  DropdownMenuItem(value: 'question', child: Text('سؤال')),
                  DropdownMenuItem(value: 'reading', child: Text('مطالعة')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => kind = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'العنوان',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: bodyController,
                maxLines: 12,
                decoration: const InputDecoration(
                  labelText: 'اكتب المحتوى هنا',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: isLoading ? null : publish,
                icon: const Icon(Icons.publish),
                label: const Text('نشر'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
