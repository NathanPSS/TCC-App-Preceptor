
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hujb_preceptor/api/registries.dart';
import 'package:hujb_preceptor/screens/registries_details.dart';

class Registry extends StatelessWidget {
  const Registry({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      return FutureBuilder(
          future: getAllRegistries(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
          {
       if(snapshot.connectionState == ConnectionState.done){
         if(snapshot.data.length == 0){
           return Center(child: Text("Não há Registros",style: Theme.of(context)
               .textTheme
               .bodyLarge!,),);
         }
         return Container(
           margin: const EdgeInsets.only(left: 36),
           child: ListView.builder(
             itemCount: snapshot.data.length,
             itemBuilder: (BuildContext context, int index) {
               return SizedBox(
                 height: 100,
                 child: InkWell(
                   onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => RegistriesDetails(index: index)));
                   },
                   child: Container(
                     decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1,color: (Theme.of(context).brightness == Brightness.light) ? Colors.black45 : Colors.white24))),
                     padding:const EdgeInsets.all(16),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         AutoSizeText(
                           'Nome: ${snapshot.data[index]['nome'].toUpperCase()}',
                           maxLines: 1,
                           overflow: TextOverflow.ellipsis,
                           stepGranularity: 12,
                           minFontSize: 12,
                         ),
                         Text('Data: ${snapshot.data[index]['date']}'),
                         Text('Duração: ${snapshot.data[index]['tempo']}')
                       ],
                     ),
                   ),
                 ),
               );
             },),
         );
       }
       return Center(child: CircularProgressIndicator());
      });
    },
    );
  }
}