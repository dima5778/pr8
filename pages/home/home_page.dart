import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/library_item.dart';
import '../../routes.dart';
import '../../services/auth_service.dart';
import '../profile_page.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  final AppUser user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  bool get _isDesktop =>
      kIsWeb ||
          defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.linux;

  Future<void> _openDetail(LibraryItem item) async {
    final result = await Navigator.of(context)
        .pushNamed(Routes.detail, arguments: item);
    if (result == 1 && mounted) {
      setState(() => _selectedIndex = 1);
    }
  }

  Widget _bordered(Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: child,
    );
  }

  Widget _libraryCard(LibraryItem item, int index) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: const Icon(Icons.menu_book, color: Colors.blue, size: 30),
        title: Text(
          '${index + 1}. ${item.name}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(item.description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _openDetail(item),
      ),
    );
  }

  Widget _statusMessage(String text, String buttonText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                context.read<HomeBloc>().add(const LoadLibraryEvent()),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  Widget _buildCovers(List<LibraryItem> items) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return Container(
            width: 140,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.asset(
                items[index].image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.menu_book,
                    size: 50,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItems(List<LibraryItem> items, bool wide, double gap) {
    if (wide) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: gap,
          crossAxisSpacing: 16,
          mainAxisExtent: 110,
        ),
        itemBuilder: (context, index) => _libraryCard(items[index], index),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (context, index) => SizedBox(height: gap),
      itemBuilder: (context, index) => _libraryCard(items[index], index),
    );
  }

  Widget _buildLibrary(HomeState state, bool wide, double gap) {
    switch (state) {
      case HomeInitial():
        return _statusMessage('Данные ещё не загружены', 'Загрузить');
      case HomeLoading():
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 48),
          child: Center(child: CircularProgressIndicator()),
        );
      case HomeError(:final message):
        return _statusMessage(message, 'Повторить');
      case HomeLoaded(:final items):
        if (items.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(child: Text('Список пуст')),
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCovers(items),
            SizedBox(height: gap),
            _buildItems(items, wide, gap),
          ],
        );
    }
  }

  Widget _buildHomeTab() {
    final double gap = _isDesktop ? 32 : 16;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool wide = constraints.maxWidth > 600;

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _bordered(
                      const Text(
                        'Онлайн-библиотека книг',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: gap),
                    _bordered(
                      const Text(
                        'Онлайн-библиотека книг — это цифровая платформа, предоставляющая '
                            'доступ к электронным книгам, аудиокнигам и научной литературе. '
                            'Она позволяет читать, скачивать и искать издания онлайн, '
                            'а также хранить персональную коллекцию избранных произведений.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(height: gap),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) =>
                          _buildLibrary(state, wide, gap),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    child: const Icon(Icons.person_outline, size: 40),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _bordered(
                      const Text(
                        'ФИО: Поспелов Дмитрий Денисович\nГруппа: ИКБО-63-23',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _selectedIndex == 0
          ? AppBar(
        title: const Text(
          'ОНЛАЙН-БИБЛИОТЕКА',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.lightGreenAccent,
        centerTitle: true,
      )
          : null,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(),
          ProfilePage(
            user: widget.user,
            onBack: () => setState(() => _selectedIndex = 0),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.lightGreen.shade100,
        indicatorColor: Colors.lightGreenAccent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}