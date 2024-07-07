

import 'package:dio/dio.dart';
import 'package:store/common/exceptions.dart';

mixin  HttpResponseValidator{
   validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}