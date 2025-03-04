import 'package:duo_app/screens/widgets/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_screen.dart';

final bottomProvider = StateProvider<int>((ref) {
  return 0;
});
final List<Widget> screens = [
  HomeScreen(), // Ana Sayfa
  Container(color: Colors.white), // Ara
  Container(color: Colors.white), // Profil
];

class BaseScreen extends ConsumerWidget {
  // Her buton için varsayılan boş ekranlar

  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          GradientBackgroundWidget(),
          screens[ref.watch(bottomProvider)],
        ],
      ),
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}

class BottomBarWidget extends ConsumerWidget {
  const BottomBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      currentIndex: ref.watch(bottomProvider),
      onTap: (index) {
        ref.read(bottomProvider.notifier).state = index;
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Ana Sayfa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Ara',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      elevation: 5,
    );
  }
}
