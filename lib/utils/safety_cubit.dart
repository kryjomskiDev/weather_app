import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SafetyCubit<State> extends BlocBase<State> {
  SafetyCubit(super.state);

  @override
  void emit(State state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
