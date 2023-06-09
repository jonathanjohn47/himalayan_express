extension DateTimeHelpes on DateTime {
  String get toDateWithShortMonthName {
    Map<int, String> monthNames = {
      1: "Jan",
      2: "Feb",
      3: "Mar",
      4: "Apr",
      5: "May",
      6: "Jun",
      7: "Jul",
      8: "Aug",
      9: "Sep",
      10: "Oct",
      11: "Nov",
      12: "Dec",
    };
    return "$day ${monthNames[month]} $year";
  }

  String get howMuchTimeAgo {
    final difference = DateTime.now().difference(this);
    if (difference.inDays > 0) {
      return "${difference.inDays}d";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}m";
    } else {
      return "${difference.inSeconds}s";
    }
  }

  String get toDateWithShortMonthNameAndTime {
    Map<int, String> monthNames = {
      1: "Jan",
      2: "Feb",
      3: "Mar",
      4: "Apr",
      5: "May",
      6: "Jun",
      7: "Jul",
      8: "Aug",
      9: "Sep",
      10: "Oct",
      11: "Nov",
      12: "Dec",
    };

    return "$day ${monthNames[month]} $year at ${hour == 12 ? '12' : "${hour % 12}".padLeft(2, '0')}:${"$minute".padLeft(2, '0')}${hour > 12 ? "PM" : "AM"}";
  }
}
