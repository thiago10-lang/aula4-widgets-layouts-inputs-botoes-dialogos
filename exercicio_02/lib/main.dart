import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercício 02',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
          shape: Border(bottom: BorderSide(color: Colors.white54)),
        ),
      ),
      home: const ResponsivePage(),
    );
  }
}

const languages = ['Dart', 'JavaScript', 'PHP', 'C++'];

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Responsive Layouts',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > constraints.maxHeight;
            return isWide ? const WideLayout() : const NarrowLayout();
          },
        ),
      ),
    );
  }
}

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Header(vertical: false),
        Expanded(child: LanguageList()),
      ],
    );
  }
}

class WideLayout extends StatelessWidget {
  const WideLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Center(child: Header(vertical: true))),
        VerticalDivider(width: 1, color: Colors.white54),
        Expanded(child: LanguageList()),
      ],
    );
  }
}

class Header extends StatelessWidget {
  final bool vertical;

  const Header({super.key, required this.vertical});

  @override
  Widget build(BuildContext context) {
    const buttons = [
      HeaderButton(label: 'BUTTON 1'),
      HeaderButton(label: 'BUTTON 2'),
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Cheetah Coding', style: TextStyle(fontSize: 26)),
          const SizedBox(height: 16),
          if (vertical)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buttons[0],
                const SizedBox(height: 12),
                buttons[1],
              ],
            )
          else
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: buttons,
            ),
        ],
      ),
    );
  }
}

class HeaderButton extends StatelessWidget {
  final String label;

  const HeaderButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black54,
        shape: const RoundedRectangleBorder(),
      ),
      onPressed: () {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('$label pressionado')));
      },
      child: Text(label, style: const TextStyle(fontSize: 11)),
    );
  }
}

class LanguageList extends StatelessWidget {
  const LanguageList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: languages.length,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, color: Colors.white54),
      itemBuilder: (context, index) => ListTile(
        title: Text(
          languages[index],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
