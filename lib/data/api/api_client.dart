
import 'package:diabetes_app/utils/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {

  late String token ;
  final String appBaseUrl ;

  late Map<String,String> _mainHeadres;

  ApiClient({required this.appBaseUrl}){
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = AppConstants.TOKEN;

    _mainHeadres={
      'Content-Type': 'application/json; charset=UTF-8',
       'Authorization': 'Bearer $token;',
    };
  }

  void updateHeader(String token){
    _mainHeadres={
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token;',
    };
  }

  Future<Response> getData(String uri,) async {
    try {
      Response response = await get(uri);
      return response;
    }
    catch(e){
      return Response(statusCode: 1 , statusText: e.toString());
    }
  }

   Future<Response> postData(String uri , dynamic body) async {

    try {
          Response response = await post(uri, body,headers: _mainHeadres);
            print("api clientttttttttttttttttttttt is workinnnnng");
          // print(response.toString());
          return response;
        }catch(e){
      print("api client not working");
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
        }
  }




}