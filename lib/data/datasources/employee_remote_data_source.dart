import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/entities/employee.dart';

abstract class EmployeeRemoteDataSource {
  Future<List<Employee>> getEmployees();
}

class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  @override
  Future<List<Employee>> getEmployees() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/employees'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

      return jsonResponse
          .map((employee) => Employee.fromJson(employee))
          .toList();
    } else {
      throw Exception('Falha ao carregar os funcionários!');
    }
  }
}
