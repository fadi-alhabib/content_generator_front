import 'dart:convert';

import 'package:content_generator_front/models/description_model.dart';
import 'package:content_generator_front/models/video_rating_model.dart';
import 'package:content_generator_front/services/api_service.dart';
import 'package:dio/dio.dart';

class AiService {
  static Future<List<String>> generateKeywords(
      {required String description}) async {
    Response? response = await ApiService.postData(path: "/keywords", data: {
      "text": description,
    });
    print(response);
    return List<String>.from(json.decode(response!.data["keywords"]));
  }

  static Future<VideoRatingModel> generateRating({required String url}) async {
    Response? response = await ApiService.postData(
        path: "/analyze_comments", data: {"url": url});

    return VideoRatingModel.fromMap(response!.data);
  }

  static Future<DescriptionModel> generateDescription(
      {required MultipartFile file}) async {
    FormData formData = FormData.fromMap({
      "file": file,
    });
    Response? response =
        await ApiService.postData(path: "/describe_video", data: formData);
    return DescriptionModel.fromMap(response!.data);
  }
}
