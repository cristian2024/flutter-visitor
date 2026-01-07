import 'package:flutter_visitor/core.dart';

class ProductsFakeData {
  static List<Product> products = [
    // Productos físicos
    const PhysicalProduct(
      id: 'p1',
      name: 'Teclado mecánico',
      value: 350000,
      description: 'Switches red, retroiluminado',
    ),
    const PhysicalProduct(id: 'p2', name: 'Mouse inalámbrico', value: 120000),
    const PhysicalProduct(id: 'p3', name: 'Monitor 27"', value: 1200000),
    const PhysicalProduct(id: 'p4', name: 'Silla ergonómica', value: 980000),
    const PhysicalProduct(id: 'p5', name: 'Audífonos', value: 260000),

    // Servicios
    const ServiceProduct(
      id: 's1',
      name: 'Suscripción streaming',
      value: 42000,
      description: 'Pago mensual',
    ),
    const ServiceProduct(
      id: 's2',
      name: 'Hosting web',
      value: 180000,
      description: 'Plan anual básico',
    ),
    const ServiceProduct(id: 's3', name: 'Mantenimiento PC', value: 150000),
    const ServiceProduct(id: 's4', name: 'Curso online Flutter', value: 320000),
    const ServiceProduct(id: 's5', name: 'Consultoría técnica', value: 500000),

    // Productos importados
    const ImportedProduct(
      id: 'i1',
      name: 'Laptop',
      value: 4800000,
      description: 'Importada desde USA',
    ),
    const ImportedProduct(id: 'i2', name: 'Tablet', value: 2100000),
    const ImportedProduct(id: 'i3', name: 'Smartphone', value: 3200000),
    const ImportedProduct(id: 'i4', name: 'Cámara mirrorless', value: 5600000),
    const ImportedProduct(id: 'i5', name: 'Impresora 3D', value: 2900000),
  ];
}
