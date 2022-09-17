import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplist/app/home/pages/shop_list/categories/cubit/product_cubit.dart';
import 'package:shoplist/app/home/pages/shop_list/cubit/add_cubit.dart';
import 'package:shoplist/app/home/pages/your_products/cubit/your_products_cubit.dart';

import 'package:shoplist/app/models/product_model.dart';
import 'package:shoplist/app/repositories/products_repositories.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({
    required this.categoriesName,
    super.key,
  });
  final String categoriesName;

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(ProductsRepository()),
      child: BlocBuilder<AddCubit, AddState>(
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ProductCubit(ProductsRepository())..start(),
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                final productModels = state.products;
                return ListView(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        for (final productModel in productModels) ...[
                          if (productModel.productGroup ==
                              widget.categoriesName) ...[
                            const SizedBox(height: 5),
                            _Dismissible(productModel: productModel),
                            const SizedBox(height: 5)
                          ],
                        ],
                      ],
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _Dismissible extends StatefulWidget {
  const _Dismissible({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  State<_Dismissible> createState() => _DismissibleState();
}

class _DismissibleState extends State<_Dismissible> {
  var isChecked = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YourProductsCubit(ProductsRepository()),
      child: BlocBuilder<YourProductsCubit, YourProductsState>(
        builder: (context, state) {
          return Dismissible(
            key: ValueKey(widget.productModel.id),
            background: DecoratedBox(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 5, 87, 29),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.check,
                    ),
                    Text('Odznacz jako kupione')
                  ],
                ),
              ),
            ),
            secondaryBackground: DecoratedBox(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 122, 12, 27),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(
                      Icons.delete_outline,
                    ),
                    Text('Usuń'),
                  ],
                ),
              ),
            ),
            confirmDismiss: (direction) async {
              return direction == DismissDirection.endToStart;
            },
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                context
                    .read<AddCubit>()
                    .delete(documentID: widget.productModel.id);
              } else {}
            },
            child: _ProductsList(
              productModel: widget.productModel,
              isChecked: true,
            ),
          );
        },
      ),
    );
  }
}

class _ProductsList extends StatelessWidget {
  const _ProductsList(
      {Key? key, required this.productModel, required this.isChecked})
      : super(key: key);

  final ProductModel productModel;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    if (isChecked == true) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromARGB(255, 11, 110, 117),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    style: const TextStyle(fontSize: 15),
                    productModel.productName),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        style: const TextStyle(fontSize: 15),
                        productModel.productQuantity.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(221, 22, 24, 24),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return _AlertDialog(productModel: productModel);
                              });
                          context
                              .read<AddCubit>()
                              .delete(documentID: productModel.id);
                        },
                        child: const Icon(
                            size: 17,
                            color: Color.fromARGB(255, 11, 170, 182),
                            Icons.shopping_bag_outlined))
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromARGB(255, 5, 53, 56),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    style: const TextStyle(fontSize: 15),
                    productModel.productName),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        style: const TextStyle(fontSize: 15),
                        productModel.productQuantity.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(221, 22, 24, 24),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return _AlertDialog(productModel: productModel);
                              });
                          context
                              .read<AddCubit>()
                              .delete(documentID: productModel.id);
                        },
                        child: const Icon(
                            size: 17,
                            color: Color.fromARGB(255, 11, 170, 182),
                            Icons.shopping_bag_outlined))
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class _AlertDialog extends StatelessWidget {
  const _AlertDialog({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YourProductsCubit(ProductsRepository())..start(),
      child: BlocBuilder<YourProductsCubit, YourProductsState>(
        builder: (context, state) {
          String? storageName;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                content: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      label: Text('Miejsce przechowywania')),
                  isExpanded: true,
                  value: storageName,
                  onChanged: (newProduct) {
                    setState((() {
                      storageName = newProduct!;
                    }));
                  },
                  items: <String>[
                    'Lodówka',
                    'Zamrażarka',
                    'Szafka',
                    'Chemia',
                    'Inne',
                  ].map<DropdownMenuItem<String>>(
                    (storageName) {
                      return DropdownMenuItem<String>(
                        value: storageName,
                        child: Text(
                          storageName,
                        ),
                      );
                    },
                  ).toList(),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<YourProductsCubit>().addYourProduct(
                            productModel.productGroup,
                            productModel.productName,
                            productModel.productQuantity,
                            storageName!,
                          );
                      Navigator.of(context).pop();
                    },
                    child: const Text('Dodaj'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
