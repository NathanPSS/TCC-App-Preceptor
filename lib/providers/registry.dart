
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hujb_preceptor/api/registries.dart';

final getAllRegistriesProvider = FutureProvider<List<Map<String,dynamic>?>?>((ref) async {
    return getAllRegistries().then((value) => value);
});

final allRegistriesState = StateNotifierProvider<RegistriesNotifier,List<Map<String,dynamic>?>?>(
        (ref) {
        return ref.watch(getAllRegistriesProvider).when(data: (data) {

          return RegistriesNotifier(data);
        }, error: (Object error, StackTrace stackTrace) { return RegistriesNotifier(null); }, loading: () { return RegistriesNotifier(null);}
        );});


class RegistriesNotifier extends StateNotifier<List<Map<String,dynamic>?>?>{
  RegistriesNotifier(super.state);

  getState(){
    return state;
  }

  getOnlyIdsState(){
    return state!.map((e) => e!['id']).toList();
  }
}