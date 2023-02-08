class ListRestaurantResult {
  ListRestaurantResult({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  bool? error;
  String? message;
  int? count;
  List<Restaurant?>? restaurants;

  factory ListRestaurantResult.fromJson(Map<String, dynamic> json) =>
      ListRestaurantResult(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: json["restaurants"] == null
            ? []
            : List<Restaurant?>.from(
                json["restaurants"]!.map((x) => Restaurant.fromJsonList(x))),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": List<dynamic>.from(restaurants!.map((x) => x!.toJsonList())),
  };
}

class DetailRestaurantResult {
  DetailRestaurantResult({
    this.error,
    this.message,
    this.restaurant,
  });

  bool? error;
  String? message;
  Restaurant? restaurant;

  factory DetailRestaurantResult.fromJson(Map<String, dynamic> json) =>
      DetailRestaurantResult(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJsonDetail(json["restaurant"]),
      );
}

class Restaurant {
  Restaurant.list({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.rating,
  });

  Restaurant.detail({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.rating,
    this.categories,
    this.menus,
    this.customerReviews,
  });

  String? id;
  String? name;
  String? description;
  String? city;
  String? address;
  String? pictureId;
  double? rating;
  List<Category?>? categories;
  Menus? menus;
  List<CustomerReview?>? customerReviews;


  factory Restaurant.fromJsonList(Map<String, dynamic> json) => Restaurant.list(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    city: json["city"],
    address: json["address"],
    pictureId: json["pictureId"],
    rating: json["rating"].toDouble(),
  );

  Map<String, dynamic> toJsonList() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "rating": rating,
  };

  factory Restaurant.fromJsonDetail(Map<String, dynamic> json) => Restaurant.detail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        rating: json["rating"].toDouble(),
        categories: json["categories"] == null
            ? []
            : List<Category?>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        customerReviews: json["customerReviews"] == null
            ? []
            : List<CustomerReview?>.from(json["customerReviews"]!
                .map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJsonDetail() => {
    "id": id,
    "name": name,
    "description": description,
    "city": city,
    "address": address,
    "pictureId": pictureId,
    "rating": rating,
    "categories": List<dynamic>.from(categories!.map((x) => x!.toJson())),
    "menus": menus?.toJson(),
    "customerReviews": List<dynamic>.from(customerReviews!.map((x) => x!.toJson())),
  };

}

class Category {
  Category({
    this.name,
  });

  String? name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class CustomerReview {
  CustomerReview({
    this.name,
    this.review,
    this.date,
  });

  String? name;
  String? review;
  String? date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "review": review,
    "date": date,
  };
}

class Menus {
  Menus({
    this.foods,
    this.drinks,
  });

  List<Category?>? foods;
  List<Category?>? drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: json["foods"] == null
            ? []
            : List<Category?>.from(
                json["foods"]!.map((x) => Category.fromJson(x))),
        drinks: json["drinks"] == null
            ? []
            : List<Category?>.from(
                json["drinks"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "foods": List<dynamic>.from(foods!.map((x) => x!.toJson())),
    "drinks": List<dynamic>.from(drinks!.map((x) => x!.toJson())),
  };
}
