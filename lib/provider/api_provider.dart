import 'package:dio/dio.dart';
import '../shared/constant/constant_data.dart';

class ApiProvider {
  static Dio api = Dio(BaseOptions(
    baseUrl: ConstantData.apiURL, connectTimeout: 50000, receiveTimeout: 50000,
    // headers: {
    //   "X-Authorization" : "1y8eGr8r75OOp2D4aMtbsDe6RJbONQL6iIOdH67COieqflQUBu52xTMFgBa6VJdE"
    // }
  ));

  static const APIKEY = "AIzaSyCBkUYS9WF-PtOKtHoWz5yqkEhqt4OMiRg";

  getPlaceSearch({text,sessionToken}) async{
    try {
      var response = await api.get("/place/autocomplete/json?input=$text&types=address&language=en&components=country:ch&key=$APIKEY&sessiontoken=$sessionToken");
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

}