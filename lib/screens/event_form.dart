import 'package:flutter/material.dart';
import '../models/event.dart';

class EventForm extends StatefulWidget {
  final AgendaEvent? event;
  const EventForm({super.key, this.event});

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  String? _country;
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event?.title ?? '');
    _descController = TextEditingController(text: widget.event?.description ?? '');
    _country = widget.event?.country;
    _date = widget.event?.date ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
  final id = widget.event?.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    final event = AgendaEvent(id: id, title: _titleController.text.trim(), description: _descController.text.trim(), country: _country, date: _date);
    Navigator.of(context).pop(event);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(widget.event == null ? 'Crear evento' : 'Editar evento'), backgroundColor: colors.primaryContainer, foregroundColor: colors.onPrimaryContainer),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _titleController, decoration: InputDecoration(labelText: 'Título', filled: true, fillColor: colors.surface, border: const OutlineInputBorder()), validator: (v) => (v ?? '').isEmpty ? 'Ingrese un título' : null),
              const SizedBox(height: 12),
              TextFormField(controller: _descController, decoration: InputDecoration(labelText: 'Descripción', filled: true, fillColor: colors.surface, border: const OutlineInputBorder())),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _country,
                decoration: InputDecoration(labelText: 'País', filled: true, fillColor: colors.surface, border: const OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: null, child: Text('-- Ninguno --')),
                  DropdownMenuItem(value: 'ES', child: Text('España')),
                  DropdownMenuItem(value: 'US', child: Text('Estados Unidos')),
                  DropdownMenuItem(value: 'MX', child: Text('México')),
                  DropdownMenuItem(value: 'AR', child: Text('Argentina')),
                ],
                onChanged: (v) => setState(() => _country = v),
              ),
              const SizedBox(height: 12),
              Row(children: [Text('Fecha: ${_date.toLocal().toString().split(' ').first}', style: TextStyle(color: colors.onSurface)), const Spacer(), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: colors.tertiaryContainer, foregroundColor: colors.onTertiaryContainer), onPressed: () async {
                final picked = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2000), lastDate: DateTime(2100));
                if (picked != null) setState(() => _date = picked);
              }, child: const Text('Seleccionar'))]),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: const Text('Guardar')),
            ],
          ),
        ),
      ),
    );
  }
}
