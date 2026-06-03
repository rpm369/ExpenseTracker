class DateTimeUtils {
  static List<String> _months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  static List<String> _weekDay = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thur",
    "Fri",
    "Sat",
  ];

  static String monthToString({required int nMonth}) {
    return _months[nMonth - 1];
  }

  static String weekToString({required int nWeek}) {
    return _weekDay[nWeek - 1];
  }

  static String format({DateTime? dateTime}) {
    dateTime ??= DateTime.now();
    String date = dateTime.day.toString();
    String month = dateTime.month.toString();
    String year = dateTime.year.toString();

    return "$date/$month/$year";
  }
}
