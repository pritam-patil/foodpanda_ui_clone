import 'package:foodpanda_ui_clone/restauTemplate.dart';
import 'package:faker/faker.dart';

RestauModel generateItem() {
  var name = faker.food.restaurant();
  var rating = random.integer(4, min: 2);
  var ratingDec = random.integer(9, min: 0);
  var reviews = random.integer(1200);
  var cuisine = faker.food.cuisine().toString();
  var restImage = "http://loremflickr.com/96/96/" + cuisine;

  return RestauModel(
    name,
    rating.toString() + "." + ratingDec.toString(),
    reviews.toString() + " reviews",
    cuisine,
    restImage.replaceAll(" ", "%20"),
  );
}

class RestauHelper {
  static var count = random.integer(50, min: 10);
  static RestauModel getItem(position) {
    return generateItem();
  }

  static var itemCount = count;
}