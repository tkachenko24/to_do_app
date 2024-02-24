import 'package:to_do_app/common/presentation/export.dart';
import 'package:to_do_app/dashboard/export.dart';

import 'widgets/export.dart';

class DashboardScreen extends StatelessWidget {
  final void Function() addNote;
  final void Function(int) toDetail;
  final ThemeData theme;

  const DashboardScreen({
    super.key,
    required this.addNote,
    required this.toDetail,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    context.read<NotesBloc>().add(const FetchNotes());
    context.read<WeatherBloc>().add(const FetchWeather());
    double height = MediaQuery.of(context).size.height;
    return PlatformScaffold(
      appBar: PlatformAppBar(
        backgroundColor: theme.primaryColor,
        title: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            return !state.someBool
                ? Text(
                    'Your notes',
                    style: Fonts.titleLarge
                        .copyWith(color: theme.scaffoldBackgroundColor),
                  )
                : PlatformSearchBar(
                    material: (context, platform) => MaterialSearchBarData(
                        constraints:
                            BoxConstraints.tight(const Size.fromHeight(40)),
                        hintStyle: MaterialStateProperty.all(
                          Fonts.bodyLarge.copyWith(color: theme.disabledColor),
                        ),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 10)),
                        hintText: 'Search'),
                    cupertino: (context, platform) => CupertinoSearchBarData(
                        prefixIcon: const SizedBox.shrink(),
                        onChanged: (value) =>
                            context.read<NotesBloc>().add(Search(value)),
                        decoration: BoxDecoration(
                            color: theme.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(15))),
                  );
          },
        ),
        leading: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            return PlatformIconButton(
              padding: EdgeInsets.zero,
              onPressed: () =>
                  context.read<NotesBloc>().add(const SwitchBool()),
              icon: Icon(
                !state.someBool
                    ? PlatformIcons(context).search
                    : PlatformIcons(context).clear,
                size: 30,
                color: theme.scaffoldBackgroundColor,
              ),
            );
          },
        ),
        trailingActions: [
          PlatformIconButton(
            padding: EdgeInsets.zero,
            onPressed: () => context.read<NotesBloc>().add(const SortList()),
            icon: Icon(
              PlatformIcons(context).shuffle,
              size: 30,
              color: theme.scaffoldBackgroundColor,
            ),
          ),
          PlatformIconButton(
            padding: EdgeInsets.zero,
            onPressed: () => addNote.call(),
            icon: Icon(
              PlatformIcons(context).add,
              size: 30,
              color: theme.scaffoldBackgroundColor,
            ),
          )
        ],
        cupertino: (context, platform) => CupertinoNavigationBarData(
            backgroundColor: theme.primaryColor,
            transitionBetweenRoutes: false),
      ),
      body: Material(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            BlocBuilder<WeatherBloc, WeatherState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                return SizedBox(
                  height: height * 0.22,
                  child: WeatherWidget(
                    theme: theme,
                    state: state,
                  ),
                );
              },
            ),
            BlocBuilder<NotesBloc, NotesState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (
                context,
                state,
              ) {
                return SizedBox(
                  height: height * 0.6,
                  child: NotesWidget(
                    state: state,
                    theme: theme,
                    toDetail: toDetail,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
