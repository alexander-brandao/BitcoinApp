import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper{
  
  final Uri uri;
  
  NetworkHelper(this.uri);
  
  Future<dynamic> getData() async{
    http.Response response = await http.get(uri);

    if(response.statusCode ==200){
      Map<String, dynamic> data = jsonDecode(response.body);
      //print(data);
      print(response.body);
      return data;
    } else {
      //print(response.statusCode);
    }
  }
  
}