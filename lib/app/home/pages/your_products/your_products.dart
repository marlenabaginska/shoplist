import 'package:flutter/material.dart';

import 'package:shoplist/app/home/pages/storage_page.dart';

class YourProductsPage extends StatelessWidget {
  const YourProductsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const StoragePage(storageName: 'Lodówka'),
              ));
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 5, 53, 56),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Lodówka'),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.kitchen_outlined)
                  ]),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    const StoragePage(storageName: 'Zamrażarka'),
              ));
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 5, 53, 56),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Zamrażarka'),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.ac_unit_rounded)
                  ]),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const StoragePage(storageName: 'Szafka'),
              ));
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 5, 53, 56),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Szafka'),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.door_sliding_outlined)
                  ]),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const StoragePage(storageName: 'Chemia'),
              ));
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 5, 53, 56),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Chemia'),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.local_laundry_service_outlined)
                  ]),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const StoragePage(storageName: 'Inne'),
              ));
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 5, 53, 56),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Inne'),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.more_horiz_outlined)
                  ]),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
