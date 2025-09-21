import 'package:equatable/equatable.dart';

class Station extends Equatable {
  final String id;
  final String name;
  final String location;

  const Station({
    required this.id,
    required this.name,
    required this.location,
  });

  @override
  List<Object?> get props => [id, name, location];

  @override
  String toString() => 'Station(id: $id, name: $name, location: $location)';
}
