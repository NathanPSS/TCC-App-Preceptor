import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hujb_preceptor/api/registries.dart';
import 'package:hujb_preceptor/global/dimensions_device.dart';
import 'package:hujb_preceptor/providers/registry.dart';
import 'package:hujb_preceptor/screens/home.dart';
import 'package:hujb_preceptor/screens/registry_deny.dart';

class RegistriesDetails extends StatefulWidget {
  int index;

  RegistriesDetails({super.key, required this.index});

  @override
  State<RegistriesDetails> createState() => _RegistriesDetailsState();
}

enum MessageRejection { alunoNaoPresente, outro }

class _RegistriesDetailsState extends State<RegistriesDetails> {
  MessageRejection? _message;
  final TextEditingController _mewssageFieldController = TextEditingController();

  Future<void> myAsyncMethod(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => HomeScreen()));

    if (context.mounted) Navigator.of(context).pop();
  }

  void showModalConfirm(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
            var registries = ref.watch(allRegistriesState.notifier).getState();
           return StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return Container(
                  height: getDeviceHeight(context: context) * 0.75,
                  margin: EdgeInsets.only(top: 24),
                  child: Stack(
                      children:[ Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: getDeviceWith(context: context) * 0.065),
                            child: Text("Motivo",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                    fontSize:
                                    getAverageDeviceSize(context: context) *
                                        0.04)),
                          ),
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
                            margin: EdgeInsets.only(right: getDeviceWith(context: context) * 0.065),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Messagem (Opcional)",
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.w700
                                    )),
                                SizedBox(
                                  width: getDeviceWith(context: context) * 0.8,
                                  child: Form(
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: _mewssageFieldController,
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
                        Positioned(
                          bottom: 0,
                          left: 0,
                          top: getDeviceHeight(context: context) * 0.65,
                          right: 16,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                                onPressed: () async {
                                  var message = _message.toString().substring(17);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => HomeScreen()));
                                 await rejectRegistry(registries[widget.index]['id'], _mewssageFieldController.value.text, message.toString());
                                  ref.refresh(getAllRegistriesProvider);
                                 Navigator.push(context,MaterialPageRoute(builder: (ctx) => HomeScreen()));
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
              },
            );
          });
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var registries = ref.watch(allRegistriesState.notifier).getState();
        return Scaffold(
          appBar: AppBar(
            title: Text("Registro"),
          ),
          body: SizedBox(
            height: getDeviceHeight(context: context),
            child: Stack(children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Nome",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize: getAverageDeviceSize(
                                                        context: context) *
                                                    0.04)),
                                    AutoSizeText(
                                      registries[widget.index]['nome']
                                          .toUpperCase(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      stepGranularity: 12,
                                      minFontSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.person,
                                  color: (Theme.of(context).brightness ==
                                          Brightness.light)
                                      ? Colors.blue[800]
                                      : Colors.blueAccent[700],
                                  size: getAverageDeviceSize(context: context) *
                                      0.056)
                            ],
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Abertura",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: getAverageDeviceSize(
                                                      context: context) *
                                                  0.04)),
                                  Text(
                                      "${registries[widget.index]['hr_entrada']}"),
                                ],
                              ),
                              Icon(Icons.input_rounded,
                                  color: (Theme.of(context).brightness ==
                                          Brightness.light)
                                      ? Colors.green[800]
                                      : Colors.greenAccent[400],
                                  size: getAverageDeviceSize(context: context) *
                                      0.056)
                            ],
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Fechamento",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: getAverageDeviceSize(
                                                      context: context) *
                                                  0.04)),
                                  Text(
                                      "${registries[widget.index]['hr_saida']}"),
                                ],
                              ),
                              Icon(Icons.output_rounded,
                                  color: (Theme.of(context).brightness ==
                                          Brightness.light)
                                      ? Colors.red[800]
                                      : Colors.redAccent,
                                  size: getAverageDeviceSize(context: context) *
                                      0.056)
                            ],
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Duração",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: getAverageDeviceSize(
                                                      context: context) *
                                                  0.04)),
                                  Text("${registries[widget.index]['tempo']}"),
                                ],
                              ),
                              Icon(Icons.timelapse_rounded,
                                  color: (Theme.of(context).brightness ==
                                          Brightness.light)
                                      ? Colors.indigo[800]
                                      : Colors.indigoAccent[400],
                                  size: getAverageDeviceSize(context: context) *
                                      0.056)
                            ],
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Data",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: getAverageDeviceSize(
                                                      context: context) *
                                                  0.04)),
                                  Text("${registries[widget.index]['date']}"),
                                ],
                              ),
                              Icon(Icons.event,
                                  color: (Theme.of(context).brightness ==
                                          Brightness.light)
                                      ? Colors.pink[800]
                                      : Colors.pinkAccent[400],
                                  size: getAverageDeviceSize(context: context) *
                                      0.056)
                            ],
                          ),
                          SizedBox(height: 24),
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Descrição",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontSize: getAverageDeviceSize(
                                                    context: context) *
                                                0.04)),
                                Text("${registries[widget.index]['descricao']}")
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getDeviceHeight(context: context) * 0.04,
                          )
                        ],
                      ),
                    ),
                  ),
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
                        showModalConfirm(context)
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent[400]),
                      child: Text(
                        "Rejeitar",
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
