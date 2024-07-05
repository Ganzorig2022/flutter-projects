import 'dart:async';
import 'dart:io';
import 'package:cashapp/constants/store_keys.dart';
import 'package:cashapp/model/result.dart';
import 'package:cashapp/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseModel extends GetConnect with ChangeNotifier implements BaseModelInterface {
  BaseModel() {
    onInit();
  }

  @override
  void onInit() {
    print('############ onInit baseModel ########');
    httpClient.defaultContentType = "application/json";
    httpClient.baseUrl = '$baseUrl/api/v1';

    httpClient.addRequestModifier<void>((request) {
      // final token = CommonUtils.getValueFromStorage<String>(StoreKey.ACCESS_TOKEN.name);
      const token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjAxNTI4OTIzMzE2Nzg3IiwibGFzdF9uYW1lIjoiRmdnIiwiZmlyc3RfbmFtZSI6IkdoaGpqIiwiZ2VuZGVyIjoiZmVtYWxlIiwiZGF0ZV9vZl9iaXJ0aCI6IjIwMjItMDgtMjIiLCJwaG9uZV9udW1iZXIiOiI4ODA3ODAxMiIsImVtYWlsIjoiZC5qYW5jaGl3QGdtYWlsLmNvbSIsImlhdCI6MTY2Nzg5NTk5OCwiZXhwIjoxNjY4MDY4Nzk4fQ.4XWB1PTjTlsNBVrZ953hmEiRyTSAdihGOxxRiM0JdPE";
      request.headers['authorization'] = 'Bearer $token';
      request.headers[HttpHeaders.acceptLanguageHeader] = Get.locale?.languageCode ?? 'mn';
      CommonUtils.print({
        'HTTP REQUEST': {
          'URL': request.url.toString(),
          'METHOD': request.method,
          'HEADERS': request.headers,
        }
      });
      return request;
    });
  }

  @override
  Future<Result> getRequest({required String urlPath}) async {
    final Response response = await get(urlPath);
    return responseHandler(response);
  }

  @override
  Future<Result> postRequest({required String urlPath, required Map data}) async {
    CommonUtils.print(data);
    final Response response = await post(urlPath, data);
    return responseHandler(response);
  }

  Future<bool> multiPartRequest({
    required List<int> image,
    String? name,
    dynamic Function(double)? uploadProgress,
  }) async {
    final form = FormData({
      'file': MultipartFile(image, filename: name ?? 'image.png'),
    });
    final response = await post('/user/image', form, uploadProgress: uploadProgress);
    print(response.body);
    return response.status.code == HttpStatus.ok || response.status.code == HttpStatus.created;
  }

  @override
  Future<Result> putRequest({required String urlPath, required Map data}) async {
    CommonUtils.print(data);
    final Response response = await put(urlPath, data);
    return responseHandler(response);
  }

  @override
  Future<Result> deleteRequest({required String urlPath}) async {
    final Response response = await delete(urlPath);
    return responseHandler(response);
  }

  Result responseHandler(Response response) {
    CommonUtils.print({
      'HTTP RESPONSE': {
        'STATUS CODE': response.statusCode,
        //     'BODY': response.body,
      }
    });

    final Result result = response.isOk ? Result.fromJson({'success': response.body, 'is_success': true}) : Result.fromJson({'error': response.body});
    if (response.isOk) return result;

    if (response.unauthorized) {
      print(response.body);
      if (getErrorCode(result) == 'AUTHENTICATION_FAILED') {
        displayErrorDialog(response.statusCode, getErrorMessage(result));
      } else if (getErrorCode(result) == 'UnauthorizedException') {
        displayErrorSnackBar('Та нэвтрэх шаардлагатай байна');
        CommonUtils.removeValueFromStorage(StoreKey.ACCESS_TOKEN.name);
        // Get.offAll(LoginPage());
      }
    } else if (response.hasError) {
      switch (response.statusCode) {
        case 400:
        case 422:
          displayErrorDialog(response.statusCode, getErrorMessage(result));
          break;
        case 404:
          displayErrorDialog(response.statusCode, 'Хүсэлт олдсонгүй');
          break;
        case 409:
          if (getErrorCode(result) == 'UniqueError') {
            displayErrorDialog(response.statusCode, 'Мэдээлэл давхардаж байна ${getErrorMessage(result)}');
          } else {
            displayErrorDialog(response.statusCode, getErrorMessage(result));
          }
          break;
        case 500:
          displayErrorDialog(response.statusCode, 'Серверийн алдаа гарлаа');
          break;
        case null:
          displayErrorDialog(response.statusCode, 'Сервер хариу өгөхгүй байна');
          break;
        default:
          displayErrorDialog(response.statusCode, 'Алдаа гарлаа');
          break;
      }
    }
    return result;
  }

  String getErrorCode(Result result) {
    return '${result.error['error']}';
  }

  String getErrorMessage(Result result) {
    return '${result.error['message']}';
  }

  displayErrorDialog(int? statusCode, String message) {
    if (!(Get.isDialogOpen ?? false)) {
      CommonUtils.showErrorDialog(title: statusCode != null ? 'Код: $statusCode' : '', message: message);
    }
  }

  displayErrorSnackBar(String message) {
    Get.snackbar(
      'Алдаа',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}

abstract class BaseModelInterface {
  Future<Result> getRequest({required String urlPath});
  Future<Result> postRequest({required String urlPath, required Map data});
  Future<Result> putRequest({required String urlPath, required Map data});
  Future<Result> deleteRequest({required String urlPath});
}
