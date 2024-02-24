import 'package:to_do_app/common/presentation/export.dart';
import 'package:to_do_app/dashboard/presentation/states/notes/bloc.dart';

class Failed extends StatelessWidget {
  const Failed({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(flex: 7),
          PlatformElevatedButton(
            onPressed: () => context.read<NotesBloc>().add(const FetchNotes()),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Try again',
                  style: Fonts.bodyLarge,
                ),
                const SizedBox(width: 5),
                Icon(
                  PlatformIcons(context).refresh,
                  size: 20,
                ),
              ],
            ),
          ),
          const Spacer(flex: 7),
        ],
      ),
    );
  }
}
