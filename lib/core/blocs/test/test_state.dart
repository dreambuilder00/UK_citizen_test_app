part of 'test_bloc.dart';

class TestPageState {
  final int selectedCount;

  const TestPageState({this.selectedCount = 0});

  TestPageState copyWith({int? selectedCount}) {
    return TestPageState(selectedCount: selectedCount ?? this.selectedCount);
  }
}
