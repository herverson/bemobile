import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:bemobile/domain/entities/employee.dart';

void main() {
  setUp(() {});

  test('return list of Employee when api is called', () async {
    final client = MockClient((request) async {
      return http.Response(
        jsonEncode([
          {
            'id': '1',
            'name': 'João',
            'job': 'Back-end',
            'admissionDate': '2019-12-02T00:00:00.000Z',
            'phone': '5551234567890',
            'image': 'https://example.com/image.jpg'
          }
        ]),
        200,
      );
    });

    final response =
        await client.get(Uri.parse('http://localhost:3000/employees'));

    final employees = jsonDecode(response.body)
        .map<Employee>((employeeJson) => Employee.fromJson(employeeJson))
        .toList();

    expect(employees.length, 1);
    expect(employees[0].name, 'João');
  });

  test('return Exception when api fails', () async {
    final client = MockClient((request) async {
      return http.Response('Error', 404);
    });

    try {
      await client.get(Uri.parse('http://localhost:3000/employees'));
    } catch (e) {
      expect(e, isA<Exception>());
    }
  });
}
