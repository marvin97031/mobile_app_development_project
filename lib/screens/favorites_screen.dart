import 'package:flutter/material.dart';

import '../services/storage_service.dart';
import '../widgets/meal_tile.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final storage = StorageService.instance;
    final favorites = storage.favorites;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Favorites')),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(storage.username),
            subtitle: Text(storage.currentUser ?? ''),
          ),
          const Divider(),
          if (favorites.isEmpty)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: Text('No favorites yet.')),
            ),
          for (final meal in favorites)
            MealTile(meal: meal, onReturn: () => setState(() {})),
        ],
      ),
    );
  }
}
