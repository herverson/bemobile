import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/employee_repository.dart';
import '../../domain/entities/employee.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository repository;
  List<Employee> _allEmployees = [];

  EmployeeCubit({required this.repository}) : super(EmployeeInitial());

  void fetchEmployees() async {
    emit(EmployeeLoading());
    try {
      _allEmployees = await repository.getEmployees();
      emit(EmployeeLoaded(_allEmployees));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  void filterEmployees(String query) {
    if (query.isEmpty) {
      emit(EmployeeLoaded(_allEmployees));
    } else {
      final filteredEmployees = _allEmployees.where((employee) {
        return employee.name.toLowerCase().contains(query.toLowerCase()) ||
            employee.job.toLowerCase().contains(query.toLowerCase()) ||
            employee.phone.contains(query);
      }).toList();
      emit(EmployeeLoaded(filteredEmployees));
    }
  }
}
