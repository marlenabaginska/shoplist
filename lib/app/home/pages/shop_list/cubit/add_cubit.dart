import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoplist/app/repositories/products_repositories.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit(this._productsRepository)
      : super(
          const AddState(),
        );

  final ProductsRepository _productsRepository;

  Future<void> add(
    String productGroup,
    String productName,
    int currentValue,
    bool isChecked,
  ) async {
    try {
      await _productsRepository.add(
        productGroup,
        productName,
        currentValue,
        isChecked,
      );
      emit(const AddState());
    } catch (error) {}
  }

  Future<void> delete({required String documentID}) {
    return _productsRepository.delete(id: documentID);
  }
}
