import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for UI
  late String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  late int isDaytime; // true or false if daytime or not

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  });

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));

      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      /* String offset = data['utc_offset'].substring(1, 3);
    

      DateTime now = DateTime.parse(datetime);

      String signo = data['utc_offset'].substring(0, 1);
      if (signo == '+') {
        now = now.add(Duration(hours: int.parse(offset)));
      } else {
        now = now.subtract(Duration(hours: int.parse(offset)));
      }*/
      String hour = data['utc_offset'].substring(0, 3);
      String mins = data['utc_offset'].substring(4, 6);
      print('Hour = $hour and mins = $mins');

      DateTime now = DateTime.parse(datetime);
      print("Now $now");

      now = now.add(Duration(hours: int.parse(hour)));
      now = now.add(Duration(minutes: int.parse(mins)));

      if (now.hour > 6 && now.hour < 17)
        isDaytime = 0;
      else if (now.hour > 17 && now.hour < 20)
        isDaytime = 1;
      else
        isDaytime = 2;

      time = DateFormat.jm().format(now);
    } catch (e) {
      print(e);
      time = 'could not get time';
    }
  }
}
