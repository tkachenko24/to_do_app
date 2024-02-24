import 'package:to_do_app/common/presentation/export.dart';
import 'package:to_do_app/dashboard/export.dart';
import 'package:to_do_app/dashboard/presentation/screens/dashboard/widgets/export.dart';

import 'widgets/export.dart';

class DetailNoteScreen extends StatelessWidget {
  final int index;
  final ThemeData theme;
  final void Function() back;
  const DetailNoteScreen({
    super.key,
    required this.back,
    required this.index,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    NotesBloc bloc = context.read<NotesBloc>();
    bloc.add(const FetchNotes());
    return PlatformScaffold(
      appBar: PlatformAppBar(
        backgroundColor: theme.primaryColor,
        title: Text(
          'Your Note',
          style:
              Fonts.titleLarge.copyWith(color: theme.scaffoldBackgroundColor),
        ),
        leading: PlatformIconButton(
          onPressed: back,
          padding: EdgeInsets.zero,
          icon: Icon(
            PlatformIcons(context).leftChevron,
            color: theme.scaffoldBackgroundColor,
          ),
        ),
        trailingActions: [
          BlocBuilder<NotesBloc, NotesState>(
            buildWhen: (previous, current) =>
                previous.someBool != current.someBool,
            builder: (context, state) {
              return state.someBool
                  ? DeleteButton(
                      bloc: bloc, index: index, back: back, theme: theme)
                  : const SizedBox.shrink();
            },
          ),
          BlocBuilder<NotesBloc, NotesState>(
            buildWhen: (previous, current) =>
                previous.someBool != current.someBool,
            builder: (context, state) {
              return SaveButton(
                  back: back, bloc: bloc, index: index, theme: theme);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Material(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocBuilder<NotesBloc, NotesState>(
              buildWhen: (previous, current) =>
                  previous.notes.length != current.notes.length ||
                  previous.someBool != current.someBool ||
                  previous.contentController.text.isEmpty ||
                  current.titleController.text.isEmpty ||
                  previous.group != current.group,
              builder: (context, state) {
                if (state.status.isSuccess() &&
                    state.contentController.text.isEmpty &&
                    state.titleController.text.isEmpty) {
                  bloc.add(
                    TitleChanged(
                      TextEditingController.fromValue(
                        TextEditingValue(text: state.notes[index].title),
                      ),
                    ),
                  );
                  bloc.add(
                    ContentChanged(
                      TextEditingController.fromValue(
                        TextEditingValue(text: state.notes[index].content),
                      ),
                    ),
                  );
                  bloc.add(
                    GroupChanged(
                      state.notes[index].group,
                    ),
                  );
                }
                return state.status.isLoading()
                    ? Loading(theme: theme)
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Spacer(
                              flex: 3,
                            ),
                            PlatformTextFormField(
                              readOnly: !state.someBool,
                              hintText: 'Title',
                              cupertino: (context, platform) =>
                                  CupertinoTextFormFieldData(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: theme.disabledColor,
                                    width: 0.2,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
                                  color: theme.dialogBackgroundColor,
                                ),
                                maxLines: 1,
                              ),
                              material: (context, platform) =>
                                  MaterialTextFormFieldData(
                                maxLines: 1,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintStyle: Fonts.bodyLarge
                                      .copyWith(color: theme.disabledColor),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              autocorrect: false,
                              controller: state.titleController,
                              onChanged: (value) => bloc.add(
                                TitleChanged(
                                  TextEditingController(text: value),
                                ),
                              ),
                            ),
                            const Spacer(
                              flex: 3,
                            ),
                            PlatformTextFormField(
                              readOnly: !state.someBool,
                              hintText: 'Content',
                              autocorrect: false,
                              cupertino: (context, platform) =>
                                  CupertinoTextFormFieldData(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: theme.disabledColor,
                                    width: 0.2,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  color: theme.dialogBackgroundColor,
                                ),
                                maxLines:
                                    (MediaQuery.of(context).size.height * 0.035)
                                        .toInt(),
                              ),
                              material: (context, platform) =>
                                  MaterialTextFormFieldData(
                                maxLines:
                                    (MediaQuery.of(context).size.height * 0.026)
                                        .toInt(),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintStyle: Fonts.bodyLarge
                                      .copyWith(color: theme.disabledColor),
                                ),
                              ),
                              onChanged: (value) => bloc.add(
                                ContentChanged(
                                  TextEditingController(text: value),
                                ),
                              ),
                              controller: state.contentController,
                              textInputAction: TextInputAction.done,
                            ),
                            const Spacer(
                              flex: 3,
                            ),
                            SegmentedButton<int>(
                              segments: const [
                                ButtonSegment(
                                  value: 0,
                                  label: Text('Work'),
                                ),
                                ButtonSegment(
                                  value: 1,
                                  label: Text('Private'),
                                ),
                                ButtonSegment(
                                  value: 2,
                                  label: Text('Cases'),
                                ),
                              ],
                              selected: <int>{state.group},
                              onSelectionChanged: state.someBool
                                  ? (value) => bloc.add(
                                        GroupChanged(value.first),
                                      )
                                  : null,
                            ),
                            const Spacer(flex: 12),
                          ],
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
