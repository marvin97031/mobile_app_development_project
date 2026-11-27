import 'package:flutter/material.dart';

import '../screens/detail_screen.dart';
import '../services/api_service.dart';

class MealTile extends StatelessWidget {
  const MealTile({super.key, required this.meal, this.onReturn});

  final Meal meal;
  final VoidCallback? onReturn;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            meal.imageUrl,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.restaurant),
          ),
        ),
        title: Text(meal.name),
        subtitle: Text('${meal.category} • ${meal.area}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => DetailScreen(meal: meal)),
          );
          onReturn?.call();
        },
      ),
    );
  }
}
