import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location;  //location name for the UI
  String time;  //the time in that location
  String flag;  //URL to an asset
  String url;  //location url for api endpoint

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try{
      //make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);
      //get properties from data
      String datetime = data['datetime'];
      String offsethours = data['utc_offset'].substring(1,3);
      String offsetmin = data['utc_offset'].substring(4,6);
      print(datetime);
      //print(offsethours);
      //print(offsetmin);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsethours), minutes: int.parse(offsetmin)));

      //set the time property

      time = DateFormat.jm().format(now);
    }
    catch(e){
      print(e);
      time = 'Could not find the time';
    }

  }
}