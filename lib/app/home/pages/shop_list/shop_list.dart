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

  int productQuantity = 1;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const _ProductGroup(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 11, 170, 182),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return AlertDialog(
                          title: const Text(
                            'Dodaj produkt do listy',
                            textAlign: TextAlign.center,
                          ),
                          content: SizedBox(
                            height: 240,
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
                                const SizedBox(
                                  height: 18,
                                ),
                                Column(
                                  children: [
                                    const Text('Ilość: '),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: NumberPicker(
                                        itemCount: 5,
                                        itemWidth: 40,
                                        axis: Axis.horizontal,
                                        value: productQuantity,
                                        minValue: 1,
                                        maxValue: 100,
                                        onChanged: (value) => setState(
                                            () => productQuantity = value),
                                      ),
                                    ),
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
                                )),
                            BlocProvider(
                              create: (context) =>
                                  AddCubit(ProductsRepository()),
                              child: BlocBuilder<AddCubit, AddState>(
                                builder: (context, state) {
                                  return ElevatedButton(
                                    onPressed: productGroup == null ||
                                            productName == null
                                        ? null
                                        : () {
                                            context.read<AddCubit>().add(
                                                  productGroup!,
                                                  productName!,
                                                  productQuantity,
                                                  isChecked,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        'Dodaj produkt do listy'),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.add, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductGroup extends StatelessWidget {
  const _ProductGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesName = [
      'Warzywa',
      'Mięso',
    ];
    return ListView.builder(
        shrinkWrap: true,
        itemCount: categoriesName.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromARGB(255, 5, 53, 56)),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      children: [
                        ExpansionTile(
                          title: Text(
                              style: const TextStyle(fontSize: 17),
                              categoriesName[index]),
                          children: [
                            CategoriesWidget(
                              categoriesName: categoriesName[index],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
