import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:bemobile/presentation/cubit/expansion_cubit.dart';

void main() {
  late ExpansionCubit expansionCubit;

  setUp(() {
    expansionCubit = ExpansionCubit();
  });

  tearDown(() {
    expansionCubit.close();
  });

  blocTest<ExpansionCubit, bool>(
    'emits [true] when toggleExpansion is called from false',
    build: () => expansionCubit,
    act: (cubit) => cubit.toggleExpansion(),
    expect: () => [true],
  );

  blocTest<ExpansionCubit, bool>(
    'emits [false] when toggleExpansion is called from true',
    build: () {
      expansionCubit.toggleExpansion();
      return expansionCubit;
    },
    act: (cubit) => cubit.toggleExpansion(),
    expect: () => [false],
  );
}
