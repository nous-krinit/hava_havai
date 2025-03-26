import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle discountedPrice = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static TextStyle realPrice = const TextStyle(
    decoration: TextDecoration.lineThrough,
    color: Colors.grey,
  );

  static TextStyle highlight =
      const TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
}
