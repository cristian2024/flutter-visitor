import 'package:flutter/material.dart';
import 'package:flutter_visitor/core.dart';

class ProductTypeTag extends StatelessWidget {
  const ProductTypeTag({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    
    return Chip(label: Text(typeTitle),padding: EdgeInsets.zero,);
  }

  String get typeTitle{
    return switch(product){
      ImportedProduct() => "Importado",
      PhysicalProduct() => "Fisico",
      ServiceProduct() => "Servicio",
      _ => ""
    };
  }
}
