import 'package:to_do_app/common/helpers/export.dart'; // Importing common helpers
import 'package:to_do_app/dashboard/domain/export.dart'; // Importing dashboard domain
import 'package:to_do_app/dashboard/infrastructure/sources/notes_database/export.dart'; // Importing notes database source

class NotesRepositoryImplementation implements NotesRepository {
  final NotesDatabase source; // Notes database source
  final NoteConverter convert; // Note converter

  NotesRepositoryImplementation({
    required this.source, // Required notes database source
    required this.convert, // Required note converter
  });

  @override
  TryFuture<NoteFailure, List<Note>> fetch() async {
    try {
      List<NoteModel> response =
          await source.fetch(); // Fetching notes from database

      List<Note> unit = response
          .map(
            (model) => convert.toEntity(model),
          )
          .toList(); // Converting list of note models to list of note entities

      return Try.success(unit); // Returning success with list of note entities
    } catch (err) {
      return Try.failed(
        NoteFailure(err), // Returning failure with error
      );
    }
  }

  @override
  TryFuture<NoteFailure, List<Note>> delete({required int index}) async {
    try {
      List<NoteModel> response =
          await source.delete(index: index); // Deleting note from database
      List<Note> unit = response
          .map(
            (model) => convert.toEntity(model),
          )
          .toList(); // Converting list of note models to list of note entities
      return Try.success(unit); // Returning success with list of note entities
    } catch (err) {
      return Try.failed(
        NoteFailure(err), // Returning failure with error
      );
    }
  }

  @override
  TryFuture<NoteFailure, List<Note>> add({required Note newNote}) async {
    try {
      List<NoteModel> response = await source.add(
          newNote: convert.toModel(newNote)); // Adding new note to database
      List<Note> unit = response
          .map(
            (model) => convert.toEntity(model),
          )
          .toList(); // Converting list of note models to list of note entities
      return Try.success(unit); // Returning success with list of note entities
    } catch (err) {
      return Try.failed(
        NoteFailure(err), // Returning failure with error
      );
    }
  }

  @override
  TryFuture<NoteFailure, List<Note>> edit({
    required Note editNote,
    required int index,
  }) async {
    try {
      List<NoteModel> response = await source.edit(
          newNote: convert.toModel(editNote),
          index: index); // Editing note in database
      List<Note> unit = response
          .map(
            (model) => convert.toEntity(model),
          )
          .toList(); // Converting list of note models to list of note entities
      return Try.success(unit); // Returning success with list of note entities
    } catch (err) {
      return Try.failed(
        NoteFailure(err), // Returning failure with error
      );
    }
  }
}
