import 'package:intl/intl.dart';

class TimeAgo {
  static String timeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    DateTime notificationDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SS").parse(dateString);
    notificationDate = notificationDate.add(Duration(hours: 14));
    final date2 = DateTime.now();

    final difference = date2.difference(notificationDate);

    if (difference.inDays > 8) {
      DateTime dateago =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SS").parse(dateString);
      return DateFormat('dd-MM-yyyy').format(dateago);
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 tuần trước' : 'tuần trước';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 ngày trước' : 'hôm qua';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 giờ trước' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 phút trước' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} giây trước';
    } else {
      return 'Vừa xong';
    }
  }
}
