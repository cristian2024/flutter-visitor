

import 'package:flutter_visitor/features/products.dart';
import 'package:get_it/get_it.dart';

final _instance = GetIt.asNewInstance();

void inject(){
  final ProductsRepository productsRepository = ProductFakeRepo();  
  _instance.registerSingleton(productsRepository);
}


T readIt<T extends Object>(){
  return _instance.get();
}