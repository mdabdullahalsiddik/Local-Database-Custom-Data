// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
 part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentModel {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? roll;
  @HiveField(2)
  String? deparment;
  StudentModel({
    this.name,
    this.roll,
    this.deparment,
  });
}
