import 'package:flutter/material.dart' show Color;

class ThemeTemplate {
  final String key;
  final String animationURL;
  final String backgroundURL;
  final Color backgroundColor;
  final Color ballColorFilled;
  final Color ballColorEmpty;

  ThemeTemplate(
      {this.animationURL,
      this.key,
      this.backgroundColor,
      this.backgroundURL,
      this.ballColorEmpty,
      this.ballColorFilled});
}
