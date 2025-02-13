import '../../domain/entities/employee.dart';
import '../datasources/employee_remote_data_source.dart';
import 'employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource remoteDataSource;

  EmployeeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Employee>> getEmployees() async {
    return await remoteDataSource.getEmployees();
  }
}
