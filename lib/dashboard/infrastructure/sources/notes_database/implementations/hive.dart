import 'package:hive_flutter/hive_flutter.dart'; // Importing Hive for local storage
import 'package:to_do_app/dashboard/infrastructure/sources/notes_database/export.dart'; // Importing notes database source

class NotesDatabaseHiveImplementation extends NotesDatabase {
  final LazyBox<dynamic> storage; // LazyBox for lazy loading of data
  final NoteConverter
      convert; // Converter for converting between models and maps

  NotesDatabaseHiveImplementation({
    required this.storage, // Required lazy storage
    required this.convert, // Required converter
  });

  static const String key = 'notes'; // Storage key for notes

  @override
  Future<List<NoteModel>> add({required NoteModel newNote}) async {
    try {
      List<NoteModel> oldStorageData =
          await fetch(); // Retrieve old list of notes from storage

      oldStorageData.add(newNote); // Add new note to the list

      List<Map<dynamic, dynamic>> newStorageData = oldStorageData
          .map(
            (model) => convert.toMap(model),
          )
          .toList(); // Convert the list of notes to a list of maps

      await storage.put(key, newStorageData); // Update storage with new data

      return await fetch(); // Retrieve and return updated list of notes
    } catch (error) {
      throw StorageException(error); // Throw StorageException in case of error
    }
  }

  @override
  Future<List<NoteModel>> delete({required int index}) async {
    try {
      List<NoteModel> oldStorageData =
          await fetch(); // Retrieve old list of notes from storage

      oldStorageData.removeAt(index); // Remove note at the specified index

      await storage.put(
        key,
        oldStorageData
            .map(
              (model) => convert.toMap(model),
            )
            .toList(),
      ); // Update storage with new list of notes

      return await fetch(); // Retrieve and return updated list of notes
    } catch (error) {
      throw StorageException(error); // Throw StorageException in case of error
    }
  }

  @override
  Future<List<NoteModel>> edit(
      {required NoteModel newNote, required int index}) async {
    try {
      List<NoteModel> storageData =
          await delete(index: index); // Delete old note at the specified index

      storageData.insert(index, newNote); // Insert new note at the same index

      await storage.put(
        key,
        storageData
            .map(
              (model) => convert.toMap(model),
            )
            .toList(),
      ); // Update storage with modified list of notes

      return fetch(); // Retrieve and return updated list of notes
    } catch (error) {
      throw StorageException(error); // Throw StorageException in case of error
    }
  }

  @override
  Future<List<NoteModel>> fetch() async {
    try {
      dynamic responseFromStorage =
          await storage.get(key); // Retrieve data from storage

      List<Map<dynamic, dynamic>> dynamicMapList =
          List<Map<dynamic, dynamic>>.from(
        responseFromStorage ?? [],
      ); // Convert dynamic data to list of maps

      List<Map<String, dynamic>> mapStringList = dynamicMapList
          .map(
            (dynamicMap) => Map<String, dynamic>.from(dynamicMap),
          )
          .toList(); // Convert maps to string-keyed maps

      List<NoteModel> modelList = mapStringList
          .map(
            (mapString) => convert.fromMap(mapString),
          )
          .toList(); // Convert maps to list of note models

      return modelList; // Return list of note models
    } catch (error) {
      throw StorageException(error); // Throw StorageException in case of error
    }
  }
}
