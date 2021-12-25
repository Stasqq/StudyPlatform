import 'package:equatable/equatable.dart';

class Class extends Equatable {
  final String name;
  final String description;

  //TODO: some kind of files/documents/materials

  Class(this.name, this.description);

  @override
  List<Object?> get props => [name, description];
}
