import 'dart:convert';

import 'package:content_generator_front/models/video_rating_model.dart';
import 'package:content_generator_front/services/api_service.dart';
import 'package:dio/dio.dart';

class AiService {
  static String aiUrl = "https://eadf-35-237-30-118.ngrok-free.app";
  static Future<List<String>> generateKeywords(
      {required String description}) async {
    Response? response =
        await ApiService.postData(path: "$aiUrl/keywords", data: {
      "text": description,
    });
    print(response);
    return List<String>.from(json.decode(response!.data["keywords"]));
  }

  static Future<VideoRatingModel> generateRating({required String url}) async {
    Response? response = await ApiService.postData(
        path: "$aiUrl/analyze_comments/", data: {"url": url});

    return VideoRatingModel.fromMap(response!.data);
  }

  static Future<String> generateDescription(
      {required MultipartFile file}) async {
    FormData formData = FormData.fromMap({
      "file": file,
    });
    Response? response = await ApiService.postData(
        path: "$aiUrl/describe_video/",
        data: formData,
        headers: {"content_type": "multipart/form-data"});
    print(response!.data);
    if (response.data["recognized_text"] != null) {
      return response.data["recognized_text"];
    }
    return response.data["greedy_caption"];
  }

  static Future<bool> validateTitle({required String title}) async {
    Response? response = await ApiService.postData(
        path: "$aiUrl/predict", data: {"text": title});

    return response!.data["prediction"] == 0 ? false : true;
  }

  static Future<String> generateTitle({required String description}) async {
    Response? response = await ApiService.postData(
        path: "$aiUrl/summarize", data: {"text": description});
    return response!.data["summary"];
  }

  static Future<String> generateImageDescription(
      {required MultipartFile file}) async {
    FormData formData = FormData.fromMap({
      "file": file,
    });
    Response? response = await ApiService.postData(
        path: "$aiUrl/generate_caption/",
        data: formData,
        headers: {"content_type": "multipart/form-data"});
    print(response!.data);
    return response.data["predicted_caption"];
  }
}
