// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VideoRatingModel {
  int? totalComments;
  int? postitiveComments;
  int? negativeComments;
  double? positivePercentage;
  double? negativePercentage;
  VideoRatingModel({
    this.totalComments,
    this.postitiveComments,
    this.negativeComments,
    this.positivePercentage,
    this.negativePercentage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_comments': totalComments,
      'positive_comments': postitiveComments,
      'negative_comments': negativeComments,
      'positive_percentage': positivePercentage,
      'negative_percentage': negativePercentage,
    };
  }

  factory VideoRatingModel.fromMap(Map<String, dynamic> map) {
    return VideoRatingModel(
      totalComments:
          map['total_comments'] != null ? map['total_comments'] as int : null,
      postitiveComments: map['positive_comments'] != null
          ? map['positive_comments'] as int
          : null,
      negativeComments: map['negative_comments'] != null
          ? map['negative_comments'] as int
          : null,
      positivePercentage: map['positive_percentage'] != null
          ? map['positive_percentage'] as double
          : null,
      negativePercentage: map['negative_percentage'] != null
          ? map['negative_percentage'] as double
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoRatingModel.fromJson(String source) =>
      VideoRatingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
