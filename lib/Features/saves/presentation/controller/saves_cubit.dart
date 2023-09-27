import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/wish_list_model.dart';

part 'saves_state.dart';

class SavesCubit extends Cubit<SavesState> {
  SavesCubit() : super(SavesInitial());
  static SavesCubit get(context) => BlocProvider.of(context);

  final Map<String, WishListModel> _wishLists = {};
}
