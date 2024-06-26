import 'package:content_generator_front/screens/describe_image_screen.dart';
import 'package:content_generator_front/screens/keywords_screen.dart';
import 'package:content_generator_front/screens/rating_screen.dart';
import 'package:content_generator_front/screens/description_screen.dart';
import 'package:content_generator_front/screens/title_screen.dart';
import 'package:content_generator_front/screens/validate_title_screen.dart';
import 'package:flutter/material.dart';

const primaryColor = Colors.black;
const iconsPath = "assets/icons/";
List containers = [
  {
    'border': Colors.lime,
    'body': Colors.lime.withOpacity(.5),
    "title": "Generate video title",
    "description": "Upload your video to generate a title for it",
    "icon": "$iconsPath/video.json",
    "routeName": TitleScreen.routeName,
  },
  {
    'border': Colors.teal,
    'body': Colors.teal.withOpacity(.5),
    "title": "Generate video Description",
    "description": "Upload your video and get a perfect description for it",
    "icon": "$iconsPath/document.json",
    "routeName": DescriptionScreen.routeName,
  },
  {
    'border': Colors.blue,
    'body': Colors.blue.withOpacity(.5),
    "title": "Validate title",
    "description": "Enter your title to validate it",
    "icon": "$iconsPath/edit.json",
    "routeName": ValidateTitleScreen.routeName,
  },
  {
    'border': Colors.pink,
    'body': Colors.pink.withOpacity(.5),
    "title": "Generate video rating from comments",
    "description":
        "Enter your video URL and get the opinion of the viewers from there comments",
    "icon": "$iconsPath/comment.json",
    "routeName": RatingScreen.routeName,
  },
  {
    'border': Colors.green,
    'body': Colors.green.withOpacity(.6),
    "title": "Generate Keywords",
    "description": "Enter video description and get the Keywords",
    "icon": "$iconsPath/heart.json",
    "routeName": KeywordsScreen.routeName,
  },
  {
    'border': Colors.purple,
    'body': Colors.purple.withOpacity(.6),
    "title": "Describe an Image",
    "description": "Upload your image and get a description for it",
    "icon": "$iconsPath/describe_image.json",
    "routeName": DescribeImageScreen.routeName,
  },
];
