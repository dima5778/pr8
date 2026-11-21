import 'package:flutter/material.dart';
import '../routes.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: const Icon(Icons.menu_book, size: 60, color: Colors.black),
            ),
            const SizedBox(height: 32),
            const Text(
              'ОНЛАЙН-БИБЛИОТЕКА',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32),
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}