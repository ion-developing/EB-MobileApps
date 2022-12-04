import 'package:flutter/material.dart';
import 'package:superestaurants/api/post/service.dart';
import 'package:superestaurants/views/auth/login.dart';

import '../api/post/post.dart';
import '../persistence/preferences.dart';

class Restaurants extends StatefulWidget {
  const Restaurants({super.key});
  @override
  State<Restaurants> createState() => RestaurantsStateful();
}

class RestaurantsStateful extends State<Restaurants> {
  late List<Post> restaurantList;
  var isLoading = true;
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    var x = PostService.listPost();
    x.then((value) => setState(() {
          restaurantList = value;
          isLoading = false;
        }));
  }
  //
  // logout() async {
  //   Preferences prefs = Preferences();
  //   await prefs.init();
  //   await prefs.deleteSession();
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => const Login()));
  // }

  @override
  Widget build(BuildContext context) => isLoading
      ? Scaffold(
          appBar: AppBar(title: const Text('Restaurants')),
          body: const Center(child: CircularProgressIndicator()))
      : Scaffold(
          appBar: AppBar(
            title: const Text('Restaurants'),
            actions: [
              IconButton(
                  onPressed: () async {
                    Preferences prefs = Preferences();
                    await prefs.init();
                    await prefs.deleteSession();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                    child: Column(
                      children: [
                        const Text(
                          'Restaurants',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        ListView.builder(
                          itemCount: restaurantList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(restaurantList[index].title),
                                leading:
                                    Image.network(restaurantList[index].poster),
                              ),
                            );
                          },
                        )
                      ],
                    )),
              ),
            ),
          ),
        );
}
