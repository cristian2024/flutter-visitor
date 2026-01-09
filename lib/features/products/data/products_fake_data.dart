import 'package:flutter_visitor/core.dart';

class ProductsFakeData {
  static final List<Product> products = [
    // Productos físicos
    const PhysicalProduct(
      id: 'p1',
      name: 'Teclado mecánico',
      value: 350000,
      description: 'Switches red, retroiluminado',
      imageLink: 'https://picsum.photos/seed/keyboard/400/400',
    ),
    const PhysicalProduct(
      id: 'p2',
      name: 'Mouse inalámbrico',
      value: 120000,
      imageLink: 'https://picsum.photos/seed/mouse/400/400',
    ),
    const PhysicalProduct(
      id: 'p3',
      name: 'Monitor 27"',
      value: 1200000,
      imageLink: 'https://picsum.photos/seed/monitor/400/400',
    ),
    const PhysicalProduct(
      id: 'p4',
      name: 'Silla ergonómica',
      value: 980000,
      imageLink: 'https://picsum.photos/seed/chair/400/400',
    ),
    const PhysicalProduct(
      id: 'p5',
      name: 'Audífonos',
      value: 260000,
      imageLink: 'https://picsum.photos/seed/headphones/400/400',
    ),

    // Servicios
    const ServiceProduct(
      id: 's1',
      name: 'Suscripción streaming',
      value: 42000,
      description: 'Pago mensual',
      imageLink: 'https://picsum.photos/seed/streaming/400/400',
    ),
    const ServiceProduct(
      id: 's2',
      name: 'Hosting web',
      value: 180000,
      description: 'Plan anual básico',
      imageLink: 'https://picsum.photos/seed/hosting/400/400',
    ),
    const ServiceProduct(
      id: 's3',
      name: 'Mantenimiento PC',
      value: 150000,
      imageLink: 'https://picsum.photos/seed/maintenance/400/400',
    ),
    const ServiceProduct(
      id: 's4',
      name: 'Curso online Flutter',
      value: 320000,
      imageLink: 'https://picsum.photos/seed/flutter/400/400',
    ),
    const ServiceProduct(
      id: 's5',
      name: 'Consultoría técnica',
      value: 500000,
      imageLink: 'https://picsum.photos/seed/consulting/400/400',
    ),

    // Productos importados
    const ImportedProduct(
      id: 'i1',
      name: 'Laptop',
      value: 4800000,
      description: 'Importada desde USA',
      imageLink: 'https://picsum.photos/seed/laptop/400/400',
    ),
    const ImportedProduct(
      id: 'i2',
      name: 'Tablet',
      value: 2100000,
      imageLink: 'https://picsum.photos/seed/tablet/400/400',
    ),
    const ImportedProduct(
      id: 'i3',
      name: 'Smartphone',
      value: 3200000,
      imageLink: 'https://picsum.photos/seed/phone/400/400',
    ),
    const ImportedProduct(
      id: 'i4',
      name: 'Cámara mirrorless',
      value: 5600000,
      imageLink: 'https://picsum.photos/seed/camera/400/400',
    ),
    const ImportedProduct(
      id: 'i5',
      name: 'Impresora 3D',
      value: 2900000,
      imageLink: 'https://picsum.photos/seed/3dprinter/400/400',
    ),
  ];
}
