import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// * Generate new global function
part 'date_formatter.g.dart';

// * Add new syntax, naming conventions
@riverpod
DateFormat dateFormatter(DateFormatterRef ref) {
  /// Date formatter to be used in the app.
  return DateFormat.MMMEd();
}
