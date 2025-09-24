class AgendaEvent {
  final String id;
  final String title;
  final String? description;
  final String? country;
  final DateTime date;

  AgendaEvent({required this.id, required this.title, this.description, this.country, required this.date});

  AgendaEvent copyWith({String? id, String? title, String? description, String? country, DateTime? date}) {
    return AgendaEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      country: country ?? this.country,
      date: date ?? this.date,
    );
  }
}
