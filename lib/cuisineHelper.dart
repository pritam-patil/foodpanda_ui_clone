import 'package:faker/faker.dart';

class CuisineHelper {
  static String getCuisine() {
    return faker.food.cuisine().toString();
  }

  static int getDiscount() {
    return random.integer(50, min: 5);
  }
}