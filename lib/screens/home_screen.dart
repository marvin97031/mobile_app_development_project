import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../widgets/app_logo.dart';
import '../widgets/meal_tile.dart';
import '../widgets/settings_menu.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _api = ApiService();
  late Future<List<Meal>> _meals = _api.searchMeals('chicken');

  void _search(String query) {
    setState(() {
      _meals = _api.searchMeals(query.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppLogo(),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Favorites',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const FavoritesScreen()),
            ),
          ),
        ],
      ),
      drawer: const SettingsMenu(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Hello, ${StorageService.instance.username}!',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: _search,
              decoration: const InputDecoration(
                hintText: 'Search recipes',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Meal>>(
              future: _meals,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: FilledButton(
                      onPressed: () => _search('chicken'),
                      child: const Text('Could not load data. Retry'),
                    ),
                  );
                }
                final meals = snapshot.data!;
                if (meals.isEmpty) {
                  return const Center(child: Text('No recipes found.'));
                }
                return ListView.builder(
                  itemCount: meals.length,
                  itemBuilder: (_, i) => MealTile(meal: meals[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
