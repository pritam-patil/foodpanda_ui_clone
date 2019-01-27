import 'package:foodpanda_ui_clone/dishTemplate.dart';
import 'package:faker/faker.dart';

DishModel getDish() {
  var name = faker.food.dish();
  var hotel = faker.food.restaurant();
  var dishPic = "http://loremflickr.com/300/200/" + name;
  bool type = random.integer(100, min: 1) < 50 ? false : true;
  var price = random.integer(29, min: 1);

  return DishModel(
    name,
    hotel.length > 15 ? hotel.split(" ")[0]: hotel,
    dishPic.replaceAll(" ", "%20"),
    type,
    price
  );
}

class DishHelper {
  static var itemCount = random.integer(100, min: 15);

  static DishModel getItem() {
    return getDish();
  }
}