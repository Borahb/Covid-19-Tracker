import 'dart:convert';

import 'package:covid19_tracker/Models/CountriesListModel.dart';
import 'package:covid19_tracker/Models/WorldStatesModel.dart';
import 'package:covid19_tracker/Services/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;


class  StatesServices {

  // fetch worldtstatesdata
  Future<WorldStatesModel> fetchWorldStatesRecords () async{

      final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

      if(response.statusCode == 200){
          var data = jsonDecode(response.body.toString());
          return WorldStatesModel.fromJson(data);
      }else{
          throw Exception('Error');
      }
  }

  // fetch countrieslist
  Future<List<dynamic>> fetchCountriesList ()async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200){

      data = jsonDecode(response.body.toString());
      return data ;

    }else{
        throw Exception(
          'Error'
        );
    }


  }




}