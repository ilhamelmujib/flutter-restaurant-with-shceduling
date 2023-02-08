import 'package:flutter/material.dart';
import 'package:flutter_restaurant/common/navigation.dart';
import 'package:flutter_restaurant/data/model/restaurant.dart';
import 'package:flutter_restaurant/provider/restaurant_detail_provider.dart';
import 'package:provider/provider.dart';

import '../provider/database_provider.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail';
  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late RestaurantDetailProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider = Provider.of<RestaurantDetailProvider>(context, listen: false);
      provider.fetchDetailRestaurant(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.black));
          } else if (state.state == ResultState.hasData) {
            return BuildDetail(restaurant: state.resultDetail.restaurant!);
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else {
            return const Center(
              child: Material(
                child: Text(''),
              ),
            );
          }
        },
      ),
    );
  }
}

class BuildDetail extends StatefulWidget{

  final Restaurant restaurant;

  const BuildDetail({super.key, required this.restaurant});

  @override
  State<BuildDetail> createState() => _BuildDetailState();
}

class _BuildDetailState extends State<BuildDetail> {

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isBookmarked(widget.restaurant.id!),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigation.back();
                      },
                    ),
                    actions: [
                      IconButton(
                        icon: isBookmarked ? const Icon(Icons.bookmark_added,
                            color: Colors.white) : const Icon(Icons.bookmark_add_outlined,
                            color: Colors.white),
                        onPressed: () {
                          if(isBookmarked) {
                            provider.removeBookmark(widget.restaurant.id!);
                          } else {
                            provider.addBookmark(widget.restaurant);
                          }
                        },
                      ),
                    ],
                    pinned: true,
                    expandedHeight: 300,
                    backgroundColor: Colors.black,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: widget.restaurant.pictureId!,
                        child: Image.network(
                          "https://restaurant-api.dicoding.dev/images/large/${widget.restaurant.pictureId!}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 10.0,
                              offset: Offset(1.0, 1.0),
                            )
                          ],
                        ),
                        child: Text(widget.restaurant.name!),
                      ),
                      titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Material(
                                    color: Colors.white,
                                    elevation: 3,
                                    borderRadius: BorderRadius.circular(10),
                                    clipBehavior: Clip.antiAlias,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 2),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                            size: 15,
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(widget.restaurant.rating.toString())
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 15,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.restaurant.city!,
                                    maxLines: 1,
                                    style: const TextStyle(color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(widget.restaurant.description!),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: widget.restaurant.categories!.map((category) {
                              return Container(
                                margin: const EdgeInsets.all(2.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    border: Border.all(color: Colors.orangeAccent)),
                                child: Text(
                                  category!.name!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Makanan",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.restaurant.menus!.foods!.map((menu) {
                              return _buildMenu(context, menu!);
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Minuman",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.restaurant.menus!.drinks!.map((menu) {
                              return _buildMenu(context, menu!);
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 19,
                          ),
                          const Text(
                            "Reviews",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Column(
                              children: widget.restaurant.customerReviews!.map((review) {
                                return _buildReview(context, review!);
                              }).toList())
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }
}

Widget _buildMenu(BuildContext context, Category category) {
  return Text(
    "- ${category.name!}",
    style: const TextStyle(
      fontSize: 16,
    ),
  );
}

Widget _buildReview(BuildContext context, CustomerReview review) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          review.name!,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          review.review!,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          review.date!,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    ),
  );
}
