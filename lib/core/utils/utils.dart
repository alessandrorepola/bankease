import 'dart:math';

class Utils {
  static DateTime serviceScheduler(DateTime from) {
    // from 45 to 60 minutes more than from
    return from.add(Duration(minutes: Random().nextInt(16) + 45));
  }
}
