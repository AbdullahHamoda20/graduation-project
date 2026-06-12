import 'dart:io';
import 'package:dio/dio.dart';

class ClinicalApiService {
  final Dio dio;

  ClinicalApiService(this.dio);

  Future<Response> submitClinicalData({
    File? image,
    required Map<String, dynamic> jsonData,
  }) async {

    FormData formData = FormData();

    // image (optional)
    if (image != null) {
      formData.files.add(
        MapEntry(
          "image",
          await MultipartFile.fromFile(image.path),
        ),
      );
    }

    //  json (optional)
    formData.fields.add(
      MapEntry("data", jsonData.toString()),
    );

    final response = await dio.post(
      "/your-endpoint",
      data: formData,
      options: Options(
        contentType: "multipart/form-data",
      ),
    );

    return response;
  }
}