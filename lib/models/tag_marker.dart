class TagMarker {
  int id = 0;
  String tagName = '';
  String tagType = '';
  String tagDescription = '';

  TagMarker({
    required this.id,
    required this.tagName,
    required this.tagType,
    required this.tagDescription,
  });

  factory TagMarker.fromJson(Map<String, dynamic> json) {
    // DateTime sessionDate = getDateFromString(json['date']);

    return TagMarker(
      id: json['idTag'] as int,
      tagName: json['tagName'] as String,
      tagType: json['tagType'] as String,
      tagDescription: json['tagDescription'] as String,
    );
  }

  @override
  String toString() {
    return 'TagMarker{id: $id, tagName: $tagName, tagType: $tagType, tagDescription: $tagDescription}';
  }
}
