import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bemobile/presentation/pages/employee_list_page.dart';
import 'package:bemobile/presentation/cubit/employee_cubit.dart';
import 'package:bemobile/domain/entities/employee.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class MockEmployeeCubit extends MockCubit<EmployeeState>
    implements EmployeeCubit {}

void main() {
  late MockEmployeeCubit mockEmployeeCubit;

  setUp(() {
    mockEmployeeCubit = MockEmployeeCubit();
  });

  tearDown(() {
    mockEmployeeCubit.close();
  });

  final employees = [
    Employee(
      id: "1",
      name: 'João',
      job: 'Back-end',
      admissionDate: '2019-12-02T00:00:00.000Z',
      phone: '5551234567890',
      image:
          'https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png',
    ),
  ];

  testWidgets('displays loading indicator when state is EmployeeLoading',
      (WidgetTester tester) async {
    whenListen(
      mockEmployeeCubit,
      Stream.fromIterable([EmployeeLoading()]),
      initialState: EmployeeLoading(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<EmployeeCubit>.value(
          value: mockEmployeeCubit,
          child: EmployeeListPage(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays error message when state is EmployeeError',
      (WidgetTester tester) async {
    whenListen(
      mockEmployeeCubit,
      Stream.fromIterable([EmployeeError('Error')]),
      initialState: EmployeeError('Error'),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<EmployeeCubit>.value(
          value: mockEmployeeCubit,
          child: EmployeeListPage(),
        ),
      ),
    );

    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('expands ExpansionTile when tapped', (WidgetTester tester) async {
    await mockNetworkImages(() async {
      whenListen(
        mockEmployeeCubit,
        Stream.fromIterable([EmployeeLoaded(employees)]),
        initialState: EmployeeLoaded(employees),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<EmployeeCubit>.value(
            value: mockEmployeeCubit,
            child: EmployeeListPage(),
          ),
        ),
      );

      await tester.pump();

      await tester.tap(find.text('João'));
      await tester.pump();

      expect(find.text('Cargo'), findsOneWidget);
      expect(find.text('Back-end'), findsOneWidget);
      expect(find.text('Data de admissão'), findsOneWidget);
      expect(find.text('02/12/2019'), findsOneWidget);
      expect(find.text('Telefone'), findsOneWidget);
      expect(find.text('+55 (51) 23456-7890'), findsOneWidget);
    });
  });
}
