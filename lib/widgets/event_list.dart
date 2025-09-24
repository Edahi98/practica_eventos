import 'package:flutter/material.dart';
import '../models/event.dart';
import 'event_card.dart';

class EventList extends StatelessWidget {
  final List<AgendaEvent> events;
  final void Function(AgendaEvent) onSelect;
  final void Function(AgendaEvent) onEdit;
  final void Function(String) onDelete;

  const EventList({super.key, required this.events, required this.onSelect, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) return const Center(child: Text('No hay eventos'));
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final e = events[index];
        return EventCard(event: e, onTap: () => onSelect(e), onEdit: onEdit, onDelete: onDelete);
      },
    );
  }
}
