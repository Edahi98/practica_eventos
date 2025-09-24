import 'package:flutter/material.dart';
import '../models/event.dart';
import '../widgets/side_menu.dart';
import '../widgets/event_list.dart';
import '../widgets/event_detail.dart';

class LargeLayout extends StatelessWidget {
  final List<AgendaEvent> events;
  final AgendaEvent? selected;
  final VoidCallback onAdd;
  final void Function(AgendaEvent) onEdit;
  final void Function(String) onDelete;
  final void Function(AgendaEvent) onSelect;

  const LargeLayout({super.key, required this.events, this.selected, required this.onAdd, required this.onEdit, required this.onDelete, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Práctica Eventos - Escritorio')),
      body: Row(
        children: [
          const SizedBox(width: 240, child: SideMenu()),
          const VerticalDivider(width: 1),
          Expanded(child: EventList(events: events, onSelect: onSelect, onEdit: onEdit, onDelete: onDelete)),
          const VerticalDivider(width: 1),
          SizedBox(width: 360, child: selected != null ? EventDetail(event: selected!) : const Center(child: Text('Seleccione un evento'))),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: onAdd, child: const Icon(Icons.add)),
    );
  }
}
