class Board {
  final int? bno;
  final String title;
  final String writer;
  final String content;

  Board({
    this.bno,
    required this.title,
    required this.writer,
    required this.content,
  });

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      bno: json['bno'],
      title: json['title'] ?? '',
      writer: json['writer'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bno': bno,
      'title': title,
      'writer': writer,
      'content': content,
    };
  }
} 