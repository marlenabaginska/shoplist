import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:shoplist/app/home/pages/shop_list/categories/categories_widget.dart';
import 'package:shoplist/app/home/pages/shop_list/cubit/add_cubit.dart';
import 'package:shoplist/app/repositories/products_repositories.dart';

class ShopListPage extends StatefulWidget {
  const ShopListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ShopListPage> createState() => _ShopListPageState();
}

class _ShopListPageState extends State<ShopListPage> {
  String? productGroup;
  String? productName;

  int currentValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return AlertDialog(
                      backgroundColor: Colors.blueGrey,
                      title: const Text(
                        'Dodaj produkt do listy',
                        textAlign: TextAlign.center,
                      ),
                      content: SizedBox(
                        height: 351,
                        child: Column(
                          children: [
                            DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  label: Text('Kategoria')),
                              isExpanded: true,
                              value: productGroup,
                              onChanged: (newProduct) {
                                setState(() {
                                  productGroup = newProduct!;
                                });
                              },
                              items: <String>[
                                'Mięso',
                                'Warzywa',
                              ].map<DropdownMenuItem<String>>(
                                (productGroup) {
                                  return DropdownMenuItem<String>(
                                    value: productGroup,
                                    child: Text(
                                      productGroup,
                                      // style: const TextStyle(color: Colors.black),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                            TextField(
                              decoration: const InputDecoration(
                                  label: Text('Nazwa produktu')),
                              onChanged: (newProduct) {
                                setState(() {
                                  productName = newProduct;
                                });
                              },
                              textAlign: TextAlign.center,
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: NumberPicker(
                                    itemWidth: 40,
                                    axis: Axis.horizontal,
                                    value: currentValue,
                                    minValue: 1,
                                    maxValue: 100,
                                    onChanged: (value) =>
                                        setState(() => currentValue = value),
                                  ),
                                ),
                                Text('Ilość: $currentValue'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cofnij',
                              style: TextStyle(color: Colors.black),
                            )),
                        BlocProvider(
                          create: (context) => AddCubit(ProductsRepository()),
                          child: BlocBuilder<AddCubit, AddState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black),
                                onPressed:
                                    productGroup == null || productName == null
                                        ? null
                                        : () {
                                            context.read<AddCubit>().add(
                                                  productGroup!,
                                                  productName!,
                                                  currentValue,
                                                );
                                            Navigator.pop(context);
                                          },
                                child: const Text('Dodaj do listy'),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  });
                }),
            child: const Text('Dodaj produkt do listy'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                Container(
                  decoration: const BoxDecoration(color: Colors.grey),
                  child: Column(
                    children: const [
                      Text('Mięso'),
                      CategoriesWidget(categoriesName: 'Mięso'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.grey),
                  child: Column(
                    children: const [
                      Text('Warzywa'),
                      CategoriesWidget(categoriesName: 'Warzywa'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
