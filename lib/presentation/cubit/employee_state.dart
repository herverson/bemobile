part of 'employee_cubit.dart';

abstract class EmployeeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<Employee> employees;

  EmployeeLoaded(this.employees);

  @override
  List<Object?> get props => [employees];
}

class EmployeeError extends EmployeeState {
  final String message;

  EmployeeError(this.message);

  @override
  List<Object?> get props => [message];
}
