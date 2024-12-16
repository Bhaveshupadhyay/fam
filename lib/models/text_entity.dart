class TextEntity {
  final String text;
  final String? color;
  final String? url;
  final String? fontStyle;

  TextEntity({
    required this.text,
    this.color,
    this.url,
    required this.fontStyle,
  });

  factory TextEntity.fromJson(Map<String, dynamic> json) => TextEntity(
    text: json['text'] ?? '',
    color: json['color'],
    url: json['url'],
    fontStyle: json['font_style'],
  );

  Map<String, dynamic> toJson() => {
    'text': text,
    'color': color,
    'font_size': url,
    'font_style': fontStyle,
  };
}