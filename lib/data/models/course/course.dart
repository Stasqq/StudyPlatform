import 'package:equatable/equatable.dart';
import 'package:study_platform/data/models/course/class.dart';

class Course extends Equatable {
  final String id;
  final String ownerUid;
  final String name;
  final String description;
  final List<Class> classes;
  final bool public;

  const Course(
      {required this.id,
      required this.name,
      required this.classes,
      required this.public,
      required this.ownerUid,
      required this.description});

  Course.withoutClasses(this.id, this.ownerUid, this.name, this.description, this.public)
      : classes = <Class>[];

  @override
  List<Object?> get props => [id, ownerUid, name, classes, public, description];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerUid': ownerUid,
      'name': name,
      'description': description,
      'classes': classes,
      'public': public,
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      ownerUid: json['ownerUid'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      classes: json['classes'] as List<Class>,
      public: json['public'] as bool,
    );
  }
}
