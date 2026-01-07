

import 'package:get_it/get_it.dart';

final _instance = GetIt.asNewInstance();

void inject(){

}


T readIt<T extends Object>(){
  return _instance.get();
}