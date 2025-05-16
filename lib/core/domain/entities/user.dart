import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  const Usuario({
    required this.id,
    required this.name,
  });

  final String id;
  final Map<String,dynamic> name;

  @override
  List<Object?> get props => [id, name];
}
