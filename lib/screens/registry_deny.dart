
import 'package:flutter/material.dart';
import 'package:hujb_preceptor/global/dimensions_device.dart';

enum MessageRejection { alunoNaoPresente, outro }

class RegistryDeny extends StatefulWidget{
  const RegistryDeny({super.key});

  @override
  State<RegistryDeny> createState() => _RegistryDenyState();
}

class _RegistryDenyState extends State<RegistryDeny> {
  MessageRejection? _message;

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Justificativa"),),
      body: Stack(
          children:[
            Container(
            margin: EdgeInsets.only(top: getDeviceHeight(context: context) * 0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadioListTile<MessageRejection>(
                    title: Text("Aluno não Compareceu"),
                    value: MessageRejection.alunoNaoPresente,
                    groupValue: _message,
                    onChanged: (value) {
                      setState(() {
                        _message = value;
                      });
                    }),
                RadioListTile<MessageRejection>(
                    title: Text("Outro"),
                    value: MessageRejection.outro,
                    groupValue: _message,
                    onChanged: (value) {
                      setState(() {
                        _message = value;
                        debugPrint(value.toString());
                      });
                    }),
                Container(
                  margin: EdgeInsets.only(left: getDeviceWith(context: context) * 0.065),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Messagem (Opcional)",
                          style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(
                        width: getDeviceWith(context: context) * 0.8,
                        child: Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  maxLines: 3,
                                  scrollPadding: EdgeInsets.only(bottom: 200),
                                  keyboardType: TextInputType.text,
                                  maxLength: 500,
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
            Positioned(
              bottom: 0,
              left: 0,
              top: getDeviceHeight(context: context) * 0.8,
              right: 16,
              child: Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    onPressed: () => {
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue),
                    child: Text(
                      "Confirmar",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
              ),
            ),
        ]
        ),
    );
  }
}