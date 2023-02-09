import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/navigation.dart';
import '../data/model/restaurant.dart';
import '../provider/database_provider.dart';
import '../provider/restaurant_provider.dart';
import 'detail_page.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorite';

  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigation.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: const Text('Favorite'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      if (provider.state == ResultState.hasData) {
        var restaurants = provider.favorite;
        return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return _buildItem(context, restaurants[index], provider);
            });
      } else {
        return Center(
          child: Material(
            child: Text(provider.message),
          ),
        );
      }
    });
  }

  Widget _buildItem(
      BuildContext context, Restaurant restaurant, DatabaseProvider provider) {
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
            IconButton(
              onPressed: () {
                provider.removeFavorite(restaurant.id!);
              },
              icon: const Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}
