import 'package:equatable/equatable.dart';
import 'package:flutter_visitor/core/domain/visitors/product_visitor.dart';

/// ------------------------------------------------------------
/// Product
/// ------------------------------------------------------------
///
/// Modelo base que representa un producto dentro del dominio
/// de la aplicación.
/// ------------------------------------------------------------
/// Propósito:
/// ------------------------------------------------------------
/// - Definir las propiedades comunes de todos los productos.
/// - Servir como punto de extensión para distintos tipos
///   concretos de productos.
/// ------------------------------------------------------------
/// Patrón de diseño:
/// ------------------------------------------------------------
/// - Implementa el patrón Visitor mediante el método `accept`.
/// - Permite ejecutar operaciones dependientes del tipo
///   de producto sin modificar sus subclases.
/// ------------------------------------------------------------
/// Propiedades:
/// ------------------------------------------------------------
/// * [id]
///   Identificador único del producto.
///
/// * [name]
///   Nombre del producto.
///
/// * [description]
///   Descripción opcional del producto.
///
/// * [imageLink]
///   URL opcional de la imagen del producto.
///
/// * [value]
///   Valor base del producto.
/// ------------------------------------------------------------
/// Comportamiento:
/// ------------------------------------------------------------
/// * accept
///   Permite que un `ProductVisitor` ejecute una operación
///   específica según el tipo concreto del producto.
/// ------------------------------------------------------------
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
