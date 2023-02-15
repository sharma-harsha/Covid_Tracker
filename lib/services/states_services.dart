import 'dart:convert';

import 'package:covid_app/Model/world_states_model.dart';
import 'package:covid_app/View/countries_list.dart';
import 'package:covid_app/services/utilities/app_urls.dart';
import 'package:http/http.dart' as http;

class StatesServices {

  Future<WorldStatesModel> fetchWorkStatesRecord () async{

    final response = await http.get(Uri.parse(AppUrl.worldStatesApi),);

    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      return WorldStatesModel.fromJson(data);
    }else{
        throw Exception('Error');
    }
  }

    Future<List<dynamic>> CountriesListApi () async{
      var data ;
    final response = await http.get(Uri.parse(AppUrl.countriesList),);

    if(response.statusCode == 200){
       data = jsonDecode(response.body.toString());
      return data;
    }else{
        throw Exception('Error');
    }
  }


}