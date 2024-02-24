import 'package:to_do_app/common/helpers/export.dart';
import 'package:to_do_app/dashboard/domain/export.dart';

abstract class NotesRepository {
  TryFuture<NoteFailure, List<Note>> fetch();
  TryFuture<NoteFailure, List<Note>> delete({required int index});
  TryFuture<NoteFailure, List<Note>> add({required Note newNote});
  TryFuture<NoteFailure, List<Note>> edit({
    required Note editNote,
    required int index,
  });
}
