import 'package:to_do_app/dashboard/domain/entities/export.dart';
import 'package:to_do_app/dashboard/infrastructure/sources/notes_database/export.dart';

class NoteConverter {
  NoteModel toModel(Note input) {
    return NoteModel(
      id: input.id,
      title: input.title,
      content: input.content,
      group: input.group,
    );
  }

  NoteModel fromMap(Map map) {
    return NoteModel(
        id: map['id'],
        title: map['title'],
        content: map['content'],
        group: map['group']);
  }

  Map<dynamic, dynamic> toMap(NoteModel model) {
    return {
      'id': model.id,
      'title': model.title,
      'content': model.content,
      'group': model.group,
    };
  }

  Note toEntity(NoteModel output) {
    return Note(
      id: output.id,
      title: output.title,
      content: output.content,
      group: output.group,
    );
  }
}
