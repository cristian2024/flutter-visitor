

import 'package:flutter_visitor/features/products.dart';
import 'package:get_it/get_it.dart';

final _instance = GetIt.asNewInstance();

/// ------------------------------------------------------------
/// inject
/// ------------------------------------------------------------
///
/// Función encargada de inicializar y registrar las
/// dependencias de la aplicación en el contenedor de
/// inyección.
/// ------------------------------------------------------------
void inject(){
  final ProductsRepository productsRepository = ProductFakeRepo();  
  _instance.registerSingleton(productsRepository);
}


/// ------------------------------------------------------------
/// readIt
/// ------------------------------------------------------------
///
/// Función utilitaria para obtener una dependencia registrada
/// en el contenedor de inyección.
/// ------------------------------------------------------------
/// Genérico:
/// ------------------------------------------------------------
/// * [T]
///   Tipo de la dependencia solicitada.
/// ------------------------------------------------------------
/// Retorno:
/// ------------------------------------------------------------
/// - Instancia registrada del tipo solicitado.
/// ------------------------------------------------------------
T readIt<T extends Object>(){
  return _instance.get();
}