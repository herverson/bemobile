import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String id;
  final String name;
  final String job;
  final String admissionDate;
  final String phone;
  final String image;

  const Employee({
    required this.id,
    required this.name,
    required this.job,
    required this.admissionDate,
    required this.phone,
    required this.image,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      job: json['job'] ?? '',
      admissionDate: json['admission_date'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, job, admissionDate, phone, image];
}
