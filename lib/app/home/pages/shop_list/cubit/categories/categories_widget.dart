import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplist/app/home/pages/shop_list/cubit/shop_list_cubit.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    required this.categoriesName,
    super.key,
  });
  final String categoriesName;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..start(),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return ListView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final product in state.products) ...[
                    if (product['product_group'] == categoriesName) ...[
                      Text(product['product_name']),
                      Text(product['product_quantity']),
                    ],
                  ],
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
