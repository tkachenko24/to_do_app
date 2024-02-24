import 'package:to_do_app/common/export.dart';

class Note extends Entity {
  final int id;
  final String title;
  final String content;
  final int group;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.group,
  });

  Note copyWith({
    int? id,
    String? title,
    String? content,
    int? group,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      group: group ?? this.group,
    );
  }

  factory Note.empty() {
    return const Note(
      id: 0,
      title: '',
      content: '',
      group: 1,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        group,
      ];
}
