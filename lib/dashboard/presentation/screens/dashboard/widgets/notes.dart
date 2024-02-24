import 'package:flutter/material.dart';
import 'package:to_do_app/dashboard/presentation/export.dart';
import 'package:to_do_app/dashboard/presentation/screens/dashboard/widgets/export.dart';

class NotesWidget extends StatelessWidget {
  final NotesState state;
  final ThemeData theme;
  final void Function(int) toDetail;
  const NotesWidget({
    super.key,
    required this.state,
    required this.theme,
    required this.toDetail,
  });

  @override
  Widget build(BuildContext context) {
    return state.status.isLoading()
        ? Loading(theme: theme)
        : state.status.isSuccess()
            ? state.notes.isNotEmpty
                ? NoteList(
                    list: state.searchResult.isNotEmpty
                        ? state.searchResult
                        : state.notes,
                    toDetail: toDetail,
                    theme: theme,
                  )
                : EmptyList(theme: theme)
            : Failed(theme: theme);
  }
}
