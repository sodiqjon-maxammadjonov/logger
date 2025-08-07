import 'package:flutter/material.dart';

import '../../domain/repositories/auth_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _authRepository = AuthRepository();
  bool _isLoading = false;
  late final ScrollController _scrollController;
  bool _isAppBarTitleVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    const scrollThreshold = 80.0;
    if (_scrollController.offset >= scrollThreshold && !_isAppBarTitleVisible) {
      setState(() => _isAppBarTitleVisible = true);
    } else if (_scrollController.offset < scrollThreshold &&
        _isAppBarTitleVisible) {
      setState(() => _isAppBarTitleVisible = false);
    }
  }

  Future<void> _performSignUp() async {
    setState(() => _isLoading = true);

    await _authRepository.signUp(
      fullName: 'Test User',
      username: 'test',
      email: 'test@test.com',
      password: '123',
    );

    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Muvaffaqiyatli ro‘yxatdan o‘tdingiz! Endi tizimga kirishingiz mumkin.',
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _isAppBarTitleVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: const Text("Hisob yaratish"),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Hisob yaratish",
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Yangi hisob ochib, bizga qo'shiling",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 48),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Toʻliq ism',
                prefixIcon: Icon(Icons.badge_outlined),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Parol',
                prefixIcon: Icon(Icons.lock_outline_rounded),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _performSignUp,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Ro'yxatdan o'tish"),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Hisobingiz bormi?"),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Kirish"),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
