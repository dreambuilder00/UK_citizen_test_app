import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestPageBloc extends Bloc<TestPageEvent, TestPageState> {
  TestPageBloc() : super(const TestPageState());

  Stream<TestPageState> mapEventToState(TestPageEvent event) async* {
    if (event is AnswerSelected) {
      final selectedCount = state.selectedCount + 1;
      yield state.copyWith(selectedCount: selectedCount);
    }
  }
}
