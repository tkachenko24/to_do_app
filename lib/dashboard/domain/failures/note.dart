import 'package:to_do_app/common/helpers/failure.dart';

class NoteFailure extends Failure {
  final Object error;
  const NoteFailure(this.error);
}
