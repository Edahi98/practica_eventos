import 'package:flutter/material.dart';
import 'models/event.dart';
import 'screens/large_layout.dart';
import 'screens/medium_layout.dart';
import 'screens/small_layout.dart';
import 'screens/event_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ColorScheme.fromSeed(seedColor: const Color(0xFF7B1FA2)); // seed morado
    final colorScheme = base.copyWith(
      secondary: const Color(0xFFFF6EB4), // rosa de acento
      secondaryContainer: const Color(0xFFFFC1E3),
      tertiary: const Color(0xFFCE93D8),
    );
    return MaterialApp(
      title: 'Práctica Eventos',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        appBarTheme: AppBarTheme(backgroundColor: colorScheme.primary, foregroundColor: colorScheme.onPrimary),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: colorScheme.secondary, foregroundColor: colorScheme.onSecondary),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary, foregroundColor: colorScheme.onPrimary)),
  cardColor: colorScheme.surface,
        scaffoldBackgroundColor: colorScheme.surface,
        dividerColor: colorScheme.outline,
      ),
      home: const ResponsiveHome(),
    );
  }
}

class ResponsiveHome extends StatefulWidget {
  const ResponsiveHome({super.key});

  @override
  State<ResponsiveHome> createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome> {
  final List<AgendaEvent> _events = [
    AgendaEvent(id: '1', title: 'Reunión equipo', description: 'Revisión semanal', date: DateTime.now().add(const Duration(days: 1))),
    AgendaEvent(id: '2', title: 'Llamada cliente', description: 'Demo del producto', date: DateTime.now().add(const Duration(days: 2))),
  ];

  AgendaEvent? _selected;

  void _addEvent(AgendaEvent e) {
    setState(() {
      _events.add(e);
    });
  }

  void _updateEvent(AgendaEvent updated) {
    setState(() {
      final idx = _events.indexWhere((e) => e.id == updated.id);
      if (idx >= 0) _events[idx] = updated;
      if (_selected?.id == updated.id) _selected = updated;
    });
  }

  void _deleteEvent(String id) {
    setState(() {
      _events.removeWhere((e) => e.id == id);
      if (_selected?.id == id) _selected = null;
    });
  }

  void _selectEvent(AgendaEvent e) {
    setState(() => _selected = e);
  }

  Future<void> _openForm([AgendaEvent? event]) async {
    final result = await Navigator.of(context).push<AgendaEvent?>(
      MaterialPageRoute(builder: (_) => EventForm(event: event)),
    );
    if (result != null) {
      if (_events.any((ev) => ev.id == result.id)) {
        _updateEvent(result);
      } else {
        _addEvent(result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final mq = MediaQuery.of(context);
      final double widthFromConstraints = constraints.maxWidth;
      final double deviceWidth = mq.size.width;
      // Use the most relevant width available (constraints when available, fallback to MediaQuery)
      final double effectiveWidth = widthFromConstraints.isFinite ? widthFromConstraints : deviceWidth;

      // You can also take orientation into account if desired
      final isLandscape = mq.orientation == Orientation.landscape;

      if (effectiveWidth >= 1000 || (isLandscape && deviceWidth >= 900)) {
        return LargeLayout(
          events: _events,
          selected: _selected,
          onAdd: () => _openForm(),
          onEdit: (e) => _openForm(e),
          onDelete: (id) => _deleteEvent(id),
          onSelect: (e) => _selectEvent(e),
        );
      } else if (effectiveWidth >= 600) {
        return MediumLayout(
          events: _events,
          selected: _selected,
          onAdd: () => _openForm(),
          onEdit: (e) => _openForm(e),
          onDelete: (id) => _deleteEvent(id),
          onSelect: (e) => _selectEvent(e),
        );
      } else {
        return SmallLayout(
          events: _events,
          onAdd: () => _openForm(),
          onEdit: (e) => _openForm(e),
          onDelete: (id) => _deleteEvent(id),
          onSelect: (e) => _selectEvent(e),
        );
      }
    });
  }
}