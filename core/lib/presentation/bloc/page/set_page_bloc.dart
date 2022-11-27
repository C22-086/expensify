import 'package:flutter_bloc/flutter_bloc.dart';

class SetPage extends Cubit<int> {
  SetPage() : super(0);

  void setPage(int newPage) {
    emit(newPage);
  }
}
