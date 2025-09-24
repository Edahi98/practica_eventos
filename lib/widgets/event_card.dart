import 'package:flutter/material.dart';
import '../models/event.dart';

class EventCard extends StatelessWidget {
  final AgendaEvent event;
  final VoidCallback onTap;
  final void Function(AgendaEvent) onEdit;
  final void Function(String) onDelete;

  const EventCard({super.key, required this.event, required this.onTap, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      color: colors.surface,
      child: ListTile(
        title: Text(event.title, style: TextStyle(color: colors.onSurface, fontWeight: FontWeight.w600)),
          subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(event.description ?? '', style: TextStyle(color: colors.onSurfaceVariant)),
            if (event.country != null) Text('País: ${event.country}', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 12)),
          ]),
        trailing: PopupMenuButton<String>(onSelected: (v) {
          if (v == 'edit') onEdit(event);
          if (v == 'delete') onDelete(event.id);
        }, itemBuilder: (_) => [PopupMenuItem(value: 'edit', child: Text('Editar', style: TextStyle(color: colors.onSurface))), PopupMenuItem(value: 'delete', child: Text('Eliminar', style: TextStyle(color: colors.error)))]),
        onTap: onTap,
      ),
    );
  }
}
