class NoteModel {
  final int id;
  final String title;
  final String content;
  final int group;

  const NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.group,
  });

  factory NoteModel.empty() {
    return const NoteModel(
      id: 0,
      title: '',
      content: '',
      group: 1,
    );
  }
}
