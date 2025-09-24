import 'package:flutter/material.dart';
import '../models/event.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/event_list.dart';
import '../widgets/event_detail.dart';

class SmallLayout extends StatefulWidget {
  final List<AgendaEvent> events;
  final VoidCallback onAdd;
  final void Function(AgendaEvent) onEdit;
  final void Function(String) onDelete;
  final void Function(AgendaEvent) onSelect;

  const SmallLayout({super.key, required this.events, required this.onAdd, required this.onEdit, required this.onDelete, required this.onSelect});

  @override
  State<SmallLayout> createState() => _SmallLayoutState();
}

class _SmallLayoutState extends State<SmallLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    Widget body;
    switch (_currentIndex) {
      case 1:
        body = const Center(child: Text('Calendario'));
        break;
      case 2:
        body = const Center(child: Text('Ajustes'));
        break;
      default:
        body = EventList(events: widget.events, onSelect: (e) {
          widget.onSelect(e);
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => EventDetail(event: e)));
        }, onEdit: widget.onEdit, onDelete: widget.onDelete);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Práctica Eventos - Móvil')),
      drawer: const Drawer(child: DrawerMenu()),
      body: body,
      floatingActionButton: FloatingActionButton(backgroundColor: colors.secondary, onPressed: widget.onAdd, child: const Icon(Icons.add)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.onSurfaceVariant,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Eventos'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendario'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
    );
  }
}
