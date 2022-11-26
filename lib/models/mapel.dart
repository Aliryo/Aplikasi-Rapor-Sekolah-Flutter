class Mapel {
  final String id;
  final String title;
  final String guru;
  final String image;
  final String content;

  Mapel({
    required this.id,
    required this.title,
    required this.guru,
    required this.image,
    required this.content,
  });

  Mapel copyWith({
    String? id,
    String? title,
    String? guru,
    String? image,
    String? content,
  }) {
    return Mapel(
      id: id ?? this.id,
      title: title ?? this.title,
      guru: guru ?? this.guru,
      image: image ?? this.image,
      content: content ?? this.content,
    );
  }
}
