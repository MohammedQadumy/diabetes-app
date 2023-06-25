


import 'package:diabetes_app/data/repository/auth_repo.dart';
import 'package:get/get.dart';

import '../Models/User.dart';
import '../Models/response_model.dart';

class AuthController extends GetxController implements GetxService {

  final AuthRepo authRepo;

  AuthController({
    required this.authRepo
  });

  bool _isLoading = false ;

  bool get isLoading => _isLoading;

   Future<ResponseModel> registration(User newUser) async {


    _isLoading=true;
    Response response = (await authRepo.registration(newUser));
    late ResponseModel responseModel;
    // print("the tokeeeeeeeeeeeeeeeeen:");
     print(response.body);
    if(response.statusCode == 200){
      print("controller status is 200");
      authRepo.saveUserToken(response.body["message"]);
      responseModel = ResponseModel(true, response.body["message"]);
    }
    else{
      print(response.body["token"]);
      print("controller status is not 200");
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading=true;
    update();
    return responseModel;
  }



  Future<ResponseModel> login(String email , String password) async {

    _isLoading=true;
    Response response = (await authRepo.login(email,password));
    late ResponseModel responseModel;
    // print("the tokeeeeeeeeeeeeeeeeen:");
    print(response.body);
    if(response.statusCode == 200){
      print("controller status is 200");
      authRepo.saveUserToken(response.body["access"]);
      responseModel = ResponseModel(true, response.body["access"]);
    }
    else{
      print(response.body["token"]);
      print("controller status is not 200");
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading=true;
    update();
    return responseModel;
  }




  void saveUserUserNameAndPassword(String userName, String password)async {
     authRepo.saveUserUserNameAndPassword(userName, password);
  }

  bool clearSharedData(){
     return authRepo.clearSharedData();
  }



}