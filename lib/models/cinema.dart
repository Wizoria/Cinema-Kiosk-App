class Cinema {
  int id = 0;
  String title = '';
  String cinemaInternalName = '';

  Cinema({
    required this.id,
    required this.title,
    required this.cinemaInternalName,
  });

  factory Cinema.fromJson(Map<String, dynamic> json) {
    return Cinema(
      id: json['id'] ?? 0,
      title: json['cinemaName'] ?? '',
      cinemaInternalName: json['cinemaNameForWebRef'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Cinema{id: $id, title: $title}';
  }
}
