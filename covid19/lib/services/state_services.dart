import 'dart:convert';

import 'package:covid19/mode/world_state_model.dart';
import 'package:covid19/services/utilites/app_url.dart';
import 'package:covid19/view/world_states.dart';
import 'package:http/http.dart' as http;

class StatesServices {

Future<WorldStatesModel> fecthWorldStatesRecored () async{

final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

if(response.statusCode == 200){
   var data = jsonDecode(response.body);
   return WorldStatesModel.fromJson(data);

}else{
  throw Exception("Erroe");
}
}

Future<List<dynamic>> countriesListApi () async{
var data;
final response = await http.get(Uri.parse(AppUrl.countrieslist));

if(response.statusCode == 200){
    data = jsonDecode(response.body);
   return data;

}else{
  throw Exception("Erroe");
}
}
}