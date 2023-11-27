


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hujb_preceptor/api/registries.dart';
import 'package:hujb_preceptor/providers/registry.dart';
import 'package:hujb_preceptor/widgets/registry.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../config/brightness_mode.dart';
import '../global/dimensions_device.dart';
import 'config.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Registros"),),
      drawer: Drawer(
        child: FutureBuilder(
          future: getThemeMode(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              return Column(
                  children:[
                    SizedBox(height: 200),
                    Container(
                      padding: EdgeInsets.all(getAverageDeviceSize(context: context) * 0.064),
                      //    decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ConfigScreen()));
                        },
                        //    decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.settings,size: getAverageDeviceSize(context: context) * 0.064,),
                              SizedBox(width: 32),
                              Text("Configurações",style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                  fontSize:
                                  getAverageDeviceSize(context: context) *
                                      0.032)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]
              );
            }
            return Center(
              child: LoadingAnimationWidget.waveDots(color: Colors.white, size: 30),
            );
          },
        ),
      ),
      floatingActionButton: SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          backgroundColor: Colors.greenAccent[400],
          onPressed: () {
            debugPrint(ref.watch(allRegistriesState.notifier).getState().length.toString());
            showDialog(context: context, builder: (BuildContext context) {
              return  AlertDialog(
                title: Text("Deseja Assinar ?"),
                actions: [
                  TextButton(onPressed: (){
                  singAllRegistries();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
                  }, child: Text("Confirmar"))
                ],
                );
            });
          },
           shape:const CircleBorder(),
          child: SizedBox(
            width: 32,
            height: 32,
            child: (Theme.of(context).brightness == Brightness.light) ? Image.asset("lib/assets/signature-with-a-pen_black.png") : Image.asset("lib/assets/signature-with-a-pen.png"),
          )
        ),
      ),
      body: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
        if(ref.watch(allRegistriesState.notifier).getState() == null){
           return Center(child: CircularProgressIndicator());
      }
        return Registry();
        },)
    );
  }
}