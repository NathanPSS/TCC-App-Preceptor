import 'package:riverpod/riverpod.dart';


final allRegistriesState = StateNotifierProvider<LoadingNotifier,bool>(
        (ref) {
      return LoadingNotifier(true);
        });


class LoadingNotifier extends StateNotifier<bool>{
  LoadingNotifier(super.state);

  loadingEnds(){
    state = false;
  }
}