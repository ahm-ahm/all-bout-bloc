
extension StringsExtensionMethods on String {
  ///==================== get First 2 Characters of a word
  String getFirstTwoCharsOfEveryWord(String name) {
    ///to remove first and last white spaces of word
    String finalString = name.trim();
    List<String> names = finalString.split(" ");
    String initials = '';
    if (names.length == 1) {
      return names[0][0];
    } else {
      for (var i = 0; i < 2; i++) {
        initials += names[i][0];
      }
    }
    return initials;
  }

///==================== email validator
  bool isPasswordValid() {
    return RegExp(r'^\b3(\d{9})\b$').hasMatch(this);
  }

///============================== phone validator
  bool isPhoneNumberValid() {
    return RegExp(r'^\b3([0-9]{9})\b$').hasMatch(this);
  }

  ///======================days ago
  String getDaysAgo(String name) {
    ///to remove first and last white spaces of word
    String finalString = name.trim();
    List<String> names = finalString.split(" ");
    String initials = '';
    if (names.length == 1) {
      return names[0][0];
    } else {
      for (var i = 0; i < 2; i++) {
        initials += names[i][0];
      }
    }
    return initials;
  }

  ///======================time am/pm
  // String getTimeInAmPm(DateTime dateTime) {
  //   final time = dateTime.toString().split(' ').last;
  //   // final date=dateTime.toString().split(' ').first;
  //   return DateFormat.jm().format(DateFormat("hh:mm:ss").parse(time));
  // }
  //
  // String getTimeAMPM(String time) {
  //   return DateFormat.jm().format(DateFormat("hh:mm:ss").parse(time));
  // }
  //
  // String timeAgoCustom(DateTime date) {
  //   var now= DateTime.now();
  //   var dt=tz.TZDateTime.utc(date.year,date.month,date.day,date.hour,date.minute,date.second);
  //   var dt2=tz.TZDateTime.utc(now.year,now.month,now.day,now.hour,now.minute,now.second);
  //   Duration diff = dt2.difference(dt);
  //   log('diff:${(diff)}   $date  $dt   $dt2' );
  //   if (diff.inDays > 365) {
  //     return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  //   } else if (diff.inDays > 30) {
  //     return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  //   } else if (diff.inDays > 7) {
  //     return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  //   }
  //
  //   ///=====================to calculate days
  //   else if (diff.inDays > 1) {
  //     // print('in days===${DateFormat.E().add_jm().format(d)}');
  //
  //     return '${diff.inDays} days ago';
  //     // return '${DateFormat.E().add_jm().format(d)}';
  //   } else if (diff.inDays == 1) {
  //     // print('res===${DateFormat.E().add_jm().format(d)}');
  //     return '${diff.inDays} day ago';
  //     // return 'Today ${DateFormat.E().add_jm().format(d)}';
  //   }
  //
  //   ///=====================to calculate hours
  //   else if (diff.inHours < 24 && diff.inHours > 0) {
  //     // return "Today ${DateFormat('jm').format(d)}";
  //     return "${diff.inHours}  ${diff.inHours == 1 ? 'hour' : 'hours'} ago";
  //   }
  //
  //   ///=====================to calculate min
  //   else if (diff.inMinutes > 0) {
  //     return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  //   }
  //   return "just now";
  // }

}