import 'package:flutter/material.dart';

import '../../../blocs/bloc_provider.dart';
import '../../../blocs/item_info/item_info_bloc.dart';

class WifiCard extends StatelessWidget {
  final TextEditingController? networkNameController;
  final TextEditingController? passwordController;

  WifiCard({super.key, this.networkNameController, this.passwordController});

  final List<String> encryptionList = ['None', 'WPA/WPA2', 'WEP'];

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.maybeOf<ItemInfoBloc>(context)!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("WiFi", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                    controller: networkNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Network Name"),
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                    controller: passwordController,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Password"),
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text("Encryption:",
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 5),
                      child: StreamBuilder<String>(
                        stream: bloc.networkEncryptionStream,
                        builder: (context, snapshot) {
                          String? value = snapshot.data;
                          if ([
                            'WPA',
                            'WPA2'
                          ].contains(value?.toUpperCase())) {
                            value = 'WPA/WPA2';
                          }

                          return DropdownButton(
                            value: value ?? encryptionList.first,
                            underline: const SizedBox(),
                            alignment: Alignment.center,
                            onChanged: (value) {
                              if (value != null) {
                                bloc.setNetworkEncryption(value);
                              }
                            },
                            items: encryptionList.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ])),
    );
  }
}
