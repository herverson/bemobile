import 'package:flutter_bloc/flutter_bloc.dart';

class ExpansionCubit extends Cubit<bool> {
  ExpansionCubit() : super(false);

  void toggleExpansion() {
    emit(!state);
  }
}
