

import 'package:diabetes_app/data/repository/top_rated_repo.dart';
import 'package:get/get.dart';

class TopRatedController  extends GetxController {

  final TopRatedRepo topRatedRepo ;

  TopRatedController({required this.topRatedRepo});

  List<dynamic> _topRatedList = [];
  List<dynamic> get topRatedList => _topRatedList ;


  Future<void> getTopRatedList() async {
    Response response =  await topRatedRepo.getTopRatedMealsList();

    if(response.statusCode == 200){
      _topRatedList = [];
     // _topRatedList.addAll([12,3,4]);
      update();
    }else{

    }
  }

}