import 'package:flutter/material.dart';
import '../models/event.dart';

class EventDetail extends StatelessWidget {
  final AgendaEvent event;
  const EventDetail({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      color: colors.surfaceContainerHighest,
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(event.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: colors.onSurface)),
        const SizedBox(height: 8),
        Text(event.description ?? '', style: TextStyle(color: colors.onSurfaceVariant)),
        const SizedBox(height: 12),
        if (event.country != null) ...[
          Text('País: ${event.country}', style: TextStyle(color: colors.onSurfaceVariant)),
          const SizedBox(height: 8),
        ],
        Text('Fecha: ${event.date.toLocal().toString().split(' ').first}', style: TextStyle(color: colors.tertiary)),
      ]),
    );
  }
}
