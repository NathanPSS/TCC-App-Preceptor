import 'package:flutter/material.dart';
import 'package:hujb_preceptor/global/dimensions_device.dart';
import 'package:hujb_preceptor/widgets/switch_mode.dart';



class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Container(
        padding: EdgeInsets.all(
          getAverageDeviceSize(context: context) *
              0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Conta',style:
            Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(
                fontSize:
                getAverageDeviceSize(context: context) *
                    0.04,
                fontWeight: FontWeight.bold
            )
              ),
            SizedBox(height: getDeviceHeight(context: context) * 0.01,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Aplicativo',style:
                Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(
                    fontSize:
                    getAverageDeviceSize(context: context) *
                        0.04,
                    fontWeight: FontWeight.bold
                )
                  ,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Modo",
                    style:
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(
                      fontSize:
                      getAverageDeviceSize(context: context) *
                          0.04,
                        fontWeight: FontWeight.w200
                    )
                    ),
                    SwitchMode(),
                  ],
                )
              ],
            )
          ],
        ),
      )
    );
  }
}