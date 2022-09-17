import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplist/app/home/pages/your_products/cubit/your_products_cubit.dart';
import 'package:shoplist/app/repositories/products_repositories.dart';

class StoragePage extends StatelessWidget {
  const StoragePage({
    super.key,
    required this.storageName,
  });
  final String storageName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 45, 127, 133),
          foregroundColor: Colors.black,
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 50.0),
              child: Text(storageName),
            ),
          ),
        ),
        body: BlocProvider(
          create: (context) => YourProductsCubit(ProductsRepository())..start(),
          child: BlocBuilder<YourProductsCubit, YourProductsState>(
            builder: (context, state) {
              final purchasedProductModels = state.purchasedProducts;
              return SizedBox(
                  child: ListView(children: [
                for (final purchasedProductsModel
                    in purchasedProductModels) ...[
                  if (purchasedProductsModel.storageName == storageName) ...[
                    Dismissible(
                        key: UniqueKey(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 15),
                              Container(
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Color.fromARGB(255, 5, 53, 56)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                style: const TextStyle(
                                                    fontSize: 17),
                                                purchasedProductsModel
                                                    .purchasedProductName),
                                            Text(
                                                style: const TextStyle(
                                                    fontSize: 17),
                                                purchasedProductsModel
                                                    .purchasedProductQuantity
                                                    .toString()),
                                          ]),
                                    ),
                                  ))
                            ],
                          ),
                        ))
                  ]
                ]
              ]));
            },
          ),
        ));
  }
}
