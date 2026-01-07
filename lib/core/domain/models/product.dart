import 'package:equatable/equatable.dart';
import 'package:flutter_visitor/core/domain/visitors/product_visitor.dart';

abstract class Product extends Equatable {
  final String id;
  final String name;
  final String? description;

  final String? imageLink;

  final double value;

  const Product({
    required this.id,
    required this.name,
    required this.value,
    this.description,
    this.imageLink,
  });

  double accept(ProductVisitor visitor);

  @override
  List<Object?> get props => [id, name, description, imageLink, value];
}
