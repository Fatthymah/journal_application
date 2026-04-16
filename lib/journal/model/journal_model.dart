class Journal {
  final String id;
  final String userId;
  final String title;
  final String content;
  final String tags;
  final DateTime createdAt;

  Journal({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.tags,
    required this.createdAt,
  });

  factory Journal.fromJson(Map<String,dynamic> json){
    return Journal(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      content: json ['content'],
      tags: json['tags'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'tags': tags,
      'user_id': userId,
    };
  }
}