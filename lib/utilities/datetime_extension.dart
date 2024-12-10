extension DatetimeExtension on DateTime{
  String get hour12 {
    return hour < 13
        ? (hour == 0 ? "12 PM" : "$hour AM")
        : "${hour - 12} PM";
  }

  String get hour24 => "$hour:${minute.toString().padLeft(2,'0')}";
}