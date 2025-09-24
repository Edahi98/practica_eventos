import 'package:flutter/material.dart';
import '../models/event.dart';
import '../widgets/event_list.dart';
import '../widgets/event_detail.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/side_menu.dart';

class MediumLayout extends StatefulWidget {
  final List<AgendaEvent> events;
  final AgendaEvent? selected;
  final VoidCallback onAdd;
  final void Function(AgendaEvent) onEdit;
  final void Function(String) onDelete;
  final void Function(AgendaEvent) onSelect;

  const MediumLayout({super.key, required this.events, this.selected, required this.onAdd, required this.onEdit, required this.onDelete, required this.onSelect});

  @override
  State<MediumLayout> createState() => _MediumLayoutState();
}

class _MediumLayoutState extends State<MediumLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final mq = MediaQuery.of(context);
    final bool isPhone = mq.size.shortestSide < 600; // heuristic: phone if shortest side < 600

    Widget body;
    switch (_currentIndex) {
      case 1:
        body = const Center(child: Text('Calendario'));
        break;
      case 2:
        body = const Center(child: Text('Ajustes'));
        break;
      default:
        if (isPhone) {
          // behave like mobile: single column list and push detail on tap
          body = EventList(events: widget.events, onSelect: (e) {
            widget.onSelect(e);
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => EventDetail(event: e)));
          }, onEdit: widget.onEdit, onDelete: widget.onDelete);
        } else {
          // tablet: show side menu permanently + list + detail
          body = Row(children: [
            SizedBox(width: 240, child: SideMenu()),
            const VerticalDivider(width: 1),
            Expanded(flex: 2, child: EventList(events: widget.events, onSelect: widget.onSelect, onEdit: widget.onEdit, onDelete: widget.onDelete)),
            const VerticalDivider(width: 1),
            SizedBox(width: 360, child: widget.selected != null ? EventDetail(event: widget.selected!) : const Center(child: Text('Seleccione un evento'))),
          ]);
        }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Práctica Eventos - Tablet')),
      drawer: isPhone ? const Drawer(child: DrawerMenu()) : null,
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
