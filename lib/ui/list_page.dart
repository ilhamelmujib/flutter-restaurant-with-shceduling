import 'package:flutter/material.dart';
import 'package:flutter_restaurant/common/navigation.dart';
import 'package:flutter_restaurant/provider/restaurant_provider.dart';
import 'package:flutter_restaurant/ui/bookmarks_page.dart';
import 'package:flutter_restaurant/ui/detail_page.dart';
import 'package:flutter_restaurant/ui/settings_page.dart';
import 'package:provider/provider.dart';

import '../data/model/restaurant.dart';

class ListPage extends StatefulWidget {
  static const routeName = '/list';

  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Restaurant",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigation.intent(BookmarksPage.routeName);
              },
              icon: const Icon(Icons.bookmark)),
          IconButton(
              onPressed: () {
                Navigation.intent(SettingsPage.routeName);
              },
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              _searchBar(provider),
              Expanded(child: _buildList(context, provider))
            ],
          );
        },
      ),
    );
  }
}

Widget _searchBar(RestaurantProvider provider) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 4),
    child: Center(
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
        ),
        onChanged: (value) {
          if (value.isEmpty) {
            provider.fetchListRestaurant();
          } else {
            provider.fetchSearchRestaurant(value);
          }
        },
      ),
    ),
  );
}

Widget _buildList(BuildContext context, RestaurantProvider provider) {
  if (provider.state == ResultState.loading) {
    return const Center(
      child: CircularProgressIndicator(color: Colors.black),
    );
  } else if (provider.state == ResultState.hasData) {
    var restaurants = provider.resultList.restaurants;
    return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: restaurants?.length,
        itemBuilder: (context, index) {
          return _buildItem(context, restaurants![index]!);
        });
  } else if (provider.state == ResultState.noData) {
    return const Center(
      child: Material(
        child: Text("Restauran tidak ditemukan"),
      ),
    );
  } else if (provider.state == ResultState.error) {
    return Center(
      child: Material(
        child: Text(provider.message),
      ),
    );
  } else {
    return const Center(
      child: Material(
        child: Text(''),
      ),
    );
  }
}

Widget _buildItem(BuildContext context, Restaurant restaurant) {
  return InkWell(
    onTap: () {
      Navigation.intentWithData(DetailPage.routeName, restaurant.id);
    },
    child: Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Hero(
            tag: restaurant.pictureId!,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Material(
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.antiAlias,
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 100, maxWidth: 100),
                      child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId!}",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Material(
                    color: Colors.white,
                    elevation: 5,
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
                          Text(restaurant.rating.toString())
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    restaurant.name!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 8,
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
                      Expanded(
                        child: Text(
                          restaurant.city!,
                          maxLines: 1,
                          style: const TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
