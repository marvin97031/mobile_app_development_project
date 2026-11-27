import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../services/storage_service.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.meal});

  final Meal meal;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final meal = widget.meal;
    final favorite = StorageService.instance.isFavorite(meal.id);
    return Scaffold(
      appBar: AppBar(title: Text(meal.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              meal.imageUrl,
              height: 240,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.restaurant, size: 120),
            ),
          ),
          const SizedBox(height: 16),
          Text(meal.name, style: Theme.of(context).textTheme.headlineSmall),
          Text('${meal.category} • ${meal.area}'),
          const SizedBox(height: 12),
          FilledButton.icon(
            icon: Icon(favorite ? Icons.favorite : Icons.favorite_border),
            label: Text(
                favorite ? 'Remove from favorites' : 'Save to favorites'),
            onPressed: () async {
              await StorageService.instance.toggleFavorite(meal);
              if (mounted) setState(() {});
            },
          ),
          const SizedBox(height: 16),
          Text('Instructions',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(meal.instructions),
        ],
      ),
    );
  }
}
