import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplist/app/home/pages/shop_list/categories/cubit/product_cubit.dart';
import 'package:shoplist/app/home/pages/shop_list/cubit/add_cubit.dart';

import 'package:shoplist/app/models/product_model.dart';
import 'package:shoplist/app/repositories/products_repositories.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    required this.categoriesName,
    super.key,
  });
  final String categoriesName;
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
                          if (productModel.productGroup == categoriesName) ...[
                            const SizedBox(height: 5),
                            Dismissible(
                              key: ValueKey(productModel.id),
                              background: const DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 32.0),
                                    child: Icon(
                                      Icons.delete_outline,
                                    ),
                                  ),
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                return direction == DismissDirection.endToStart;
                              },
                              onDismissed: (direction) {
                                context
                                    .read<AddCubit>()
                                    .delete(documentID: productModel.id);
                              },
                              child: _ProductsList(productModel: productModel),
                            ),
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

class _ProductsList extends StatelessWidget {
  const _ProductsList({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 35,
        decoration: const BoxDecoration(color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(productModel.productName),
              Text(productModel.productQuantity.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
