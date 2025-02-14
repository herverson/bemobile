import 'package:bemobile/data/repositories/employee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bemobile/domain/entities/employee.dart';
import 'package:bemobile/presentation/cubit/employee_cubit.dart';
import 'package:mockito/annotations.dart';
import 'employee_cubit_test.mocks.dart';

@GenerateMocks([EmployeeRepository])
void main() {
  late EmployeeCubit employeeCubit;
  late MockEmployeeRepository mockRepository;

  setUp(() {
    mockRepository = MockEmployeeRepository();
    employeeCubit = EmployeeCubit(repository: mockRepository);
  });

  tearDown(() {
    employeeCubit.close();
  });

  final employees = [
    Employee(
      id: "1",
      name: 'João',
      job: 'Back-end',
      admissionDate: '2019-12-02T00:00:00.000Z',
      phone: '5551234567890',
      image: 'https://example.com/image.jpg',
    ),
  ];

  blocTest<EmployeeCubit, EmployeeState>(
    'emits [EmployeeLoading, EmployeeLoaded] when fetchEmployees is called',
    build: () {
      when(mockRepository.getEmployees()).thenAnswer((_) async => employees);
      return employeeCubit;
    },
    act: (cubit) => cubit.fetchEmployees(),
    expect: () => [
      EmployeeLoading(),
      EmployeeLoaded(employees),
    ],
  );

  blocTest<EmployeeCubit, EmployeeState>(
    'emits [EmployeeLoading, EmployeeError] when fetchEmployees fails',
    build: () {
      when(mockRepository.getEmployees())
          .thenThrow(Exception('Failed to load'));
      return employeeCubit;
    },
    act: (cubit) => cubit.fetchEmployees(),
    expect: () => [
      EmployeeLoading(),
      EmployeeError('Exception: Failed to load'),
    ],
  );

  blocTest<EmployeeCubit, EmployeeState>(
    'emits [EmployeeLoading, EmployeeLoaded, EmployeeLoaded] when fetchEmployees and filterEmployees are called',
    build: () {
      when(mockRepository.getEmployees()).thenAnswer((_) async => employees);
      return employeeCubit;
    },
    act: (cubit) {
      cubit.fetchEmployees();
      cubit.filterEmployees('João');
    },
    expect: () => [
      EmployeeLoading(),
      EmployeeLoaded([]),
      EmployeeLoaded(
        employees.where((e) => e.name.contains('João')).toList(),
      ),
    ],
  );
}
