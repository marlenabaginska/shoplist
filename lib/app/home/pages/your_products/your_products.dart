import 'package:flutter/material.dart';

import 'package:shoplist/app/home/pages/storage_page.dart';

class YourProductsPage extends StatelessWidget {
  const YourProductsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = [
      Icons.kitchen_outlined,
      Icons.ac_unit_rounded,
      Icons.door_sliding_outlined,
      Icons.local_laundry_service_outlined,
      Icons.more_horiz_outlined,
    ];

    final storageNames = [
      'Lodówka',
      'Zamrażarka',
      'Szafka kuchenna',
      'Chemia',
      'Inne',
    ];
    final routes = [
      const StoragePage(storageName: 'Lodówka'),
      const StoragePage(storageName: 'Zamrażarka'),
      const StoragePage(storageName: 'Szafka kuchenna'),
      const StoragePage(storageName: 'Chemia'),
      const StoragePage(storageName: 'Inne'),
    ];
    return Scaffold(
        body: ListView.builder(
      itemCount: storageNames.length,
      itemBuilder: (context, index) {
        return SizedBox(
            height: 65,
            child: Column(children: [
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      fullscreenDialog: true, builder: (_) => routes[index]));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 5, 53, 56),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(storageNames[index]),
                          const SizedBox(
                            width: 8,
                          ),
                          Icon(icon[index])
                        ]),
                  ),
                ),
              ),
            ]));
      },
    ));
  }
}
