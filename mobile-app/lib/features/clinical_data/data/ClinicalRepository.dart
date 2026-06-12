import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data/pcos_data_models.dart';
import 'ResultModel.dart';

class ClinicalRepository {
   String baseUrl;

  ClinicalRepository(this.baseUrl);

  Future<ResultModel> submit(ClinicalDataModel data) async {
    final uri = Uri.parse("$baseUrl/api/v1/diagnose");

    final request = http.MultipartRequest("POST", uri);

    // JSON data
    if(data.age != null && data.weight != null && data.height != null && data.bmi != null){
      request.fields["clinical_data"] = jsonEncode(data.toApiJson());

    }
    // Image (optional)
    if (data.ultrasoundImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "ultrasound_image",
          data.ultrasoundImage!.path,
        ),
      );
    }

    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw Exception("API Error: $body");
    }
    print(request.fields["data"]);
    final json = jsonDecode(body);
    return ResultModel.fromJson(json);

  }
}