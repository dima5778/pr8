import 'package:flutter/material.dart';
import '../models/library_item.dart';

class DetailPage extends StatelessWidget {
  final LibraryItem item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        centerTitle: true,
        title: Text(
          item.name.toUpperCase(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image.asset(
                      item.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.menu_book,
                          size: 60,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              item.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              item.description,
              style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            Text(
              item.details,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.lightGreen.shade100,
        indicatorColor: Colors.lightGreenAccent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: 0,
        onDestinationSelected: (index) => Navigator.of(context).pop(index),
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