import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplist/app/cubit/root_cubit.dart';
import 'package:shoplist/app/home/pages/recipes/recipes.dart';
import 'package:shoplist/app/home/pages/shop_list/shop_list.dart';
import 'package:shoplist/app/home/pages/your_products/your_products.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit()..root(),
      child: BlocBuilder<RootCubit, RootState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
              title: const Center(child: Text('Shop List')),
              actions: [
                IconButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                'Jesteś zalogowany jako: ',
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                '${state.user?.email}',
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cofnij')),
                                const _SignOutButton(),
                              ],
                            )),
                    icon: const Icon(Icons.person))
              ],
            ),
            body: Builder(builder: (context) {
              if (currentIndex == 0) {
                return ShopListPage();
              }
              if (currentIndex == 1) {
                return const YourProductsPage();
              }
              if (currentIndex == 2) {
                return const RecipesPage();
              }
              return Container();
            }),
            bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.white,
              currentIndex: currentIndex,
              onTap: (newIndex) {
                setState(() {
                  currentIndex = newIndex;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: '',
                  backgroundColor: Colors.grey,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: '',
                  backgroundColor: Colors.grey,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: '',
                  backgroundColor: Colors.grey,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: '',
                  backgroundColor: Colors.grey,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit(),
      child: BlocBuilder<RootCubit, RootState>(
        builder: (context, state) {
          return ElevatedButton(
              onPressed: () {
                context.read<RootCubit>().signOut();
                Navigator.of(context).pop();
              },
              child: const Text('Wyloguj'));
        },
      ),
    );
  }
}
