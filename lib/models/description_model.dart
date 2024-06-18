// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DescriptionModel {
  String? greedyCaption;
  String? beamCaption;
  DescriptionModel({
    this.greedyCaption,
    this.beamCaption,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'greedy_caption': greedyCaption,
      'beam_caption': beamCaption,
    };
  }

  factory DescriptionModel.fromMap(Map<String, dynamic> map) {
    return DescriptionModel(
      greedyCaption: map['greedy_caption'] != null
          ? map['greedy_caption'] as String
          : null,
      beamCaption:
          map['beam_caption'] != null ? map['beam_caption'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DescriptionModel.fromJson(String source) =>
      DescriptionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
