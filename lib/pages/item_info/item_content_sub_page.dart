import 'package:flutter/material.dart';

import '../../blocs/bloc_provider.dart';
import '../../blocs/item_info/item_info_bloc.dart';
import '../../blocs/item_info/item_info_event.dart';
import '../../models/models.dart';
import '../../utils/enums.dart';
import '../loading_widget.dart';
import 'widgets/email_card.dart';
import 'widgets/item_detail_card.dart';
import 'widgets/item_label_card.dart';
import 'widgets/sms_card.dart';
import 'widgets/wifi_card.dart';

class ItemContentSubPage extends StatefulWidget {
  const ItemContentSubPage({super.key});

  @override
  State<ItemContentSubPage> createState() => _ItemContentSubPageState();
}

class _ItemContentSubPageState extends State<ItemContentSubPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController urlController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController ccController = TextEditingController();
  TextEditingController bccController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  TextEditingController networkNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late ItemInfoBloc bloc;

  void initValue(ItemModel item) {
    String name = item.category!.name!.toLowerCase();
    ConstantEnum categoryName = ConstantEnum.values
        .firstWhere((ce) => ce.name == name, orElse: () => ConstantEnum.unknow);
    switch (categoryName) {
      case ConstantEnum.sms:
        SmsModel? sms = item.sms;
        phoneNumberController.text = sms?.phoneNumber ?? "";
        messageController.text = sms?.message ?? "";
        break;
      case ConstantEnum.facebook:
      case ConstantEnum.twitter:
      case ConstantEnum.youtube:
      case ConstantEnum.tiktok:
      case ConstantEnum.twitch:
        UrlModel? url = item.url;
        urlController.text = url?.url ?? "";
        break;
      case ConstantEnum.phone:
        PhoneModel? phone = item.phone;
        phoneNumberController.text = phone?.phoneNumber ?? "";
        break;
      case ConstantEnum.email:
        EmailModel? email = item.email;
        addressController.text = email?.address ?? "";
        ccController.text = email?.cc ?? "";
        bccController.text = email?.bcc ?? "";
        subjectController.text = email?.subject ?? "";
        bodyController.text = email?.body ?? "";
        break;
      case ConstantEnum.wifi:
        WifiModel? wifi = item.wifi;
        networkNameController.text = wifi?.networkName ?? "";
        passwordController.text = wifi?.password ?? "";
        bloc.setNetworkEncryption(wifi?.encryption);
        break;
      case ConstantEnum.link:
        UrlModel? url = item.url;
        urlController.text = url?.url ?? "";
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    debugPrint("ItemContentSubPage initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("ItemContentSubPage didChangeDependencies");
    bloc = BlocProvider.maybeOf<ItemInfoBloc>(context)!;

    ItemModel? item = bloc.state.item;
    if (item != null) {
      String? initialName = item.name;
      if (initialName != null) nameController.text = initialName;
      initValue(item);
    }
  }

  @override
  void didUpdateWidget(ItemContentSubPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint("ItemContentSubPage didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint("ItemContentSubPage deactivate");
  }

  @override
  void activate() {
    super.activate();
    debugPrint("ItemContentSubPage activate");
  }

  Widget getItemDetailCard(ItemCategoryModel category) {
    Widget result;
    String name = category.name!.toLowerCase();
    ConstantEnum categoryName = ConstantEnum.values
        .firstWhere((ce) => ce.name == name, orElse: () => ConstantEnum.unknow);
    switch (categoryName) {
      case ConstantEnum.sms:
        result = SmsCard(
          phoneNumberController: phoneNumberController,
          messageController: messageController,
          category: category,
        );
        break;
      case ConstantEnum.facebook:
      case ConstantEnum.twitter:
      case ConstantEnum.youtube:
      case ConstantEnum.tiktok:
      case ConstantEnum.twitch:
        result = ItemDetailCard(
          textController: urlController,
          category: category,
          label: "URL",
          showDetailLink: true,
        );
        break;
      case ConstantEnum.phone:
        result = ItemDetailCard(
            textController: phoneNumberController,
            category: category,
            label: "Phone");
        break;
      case ConstantEnum.email:
        result = EmailCard(
            addressController: addressController,
            ccController: ccController,
            bccController: bccController,
            subjectController: subjectController,
            bodyController: bodyController,
            category: category);
        break;
      case ConstantEnum.wifi:
        result = WifiCard(
            networkNameController: networkNameController,
            passwordController: passwordController);
        break;
      case ConstantEnum.link:
        result = ItemDetailCard(
            textController: urlController, category: category, label: "Link");
        break;
      default:
        result = const SizedBox();
        break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("ItemContentSubPage dispose");
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.cyan[50],
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: StreamBuilder<int>(
          stream: bloc.selectedItemIdStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LoadingWidget();
            }
            ItemCategoryModel category = bloc.state.itemCategories!
                .firstWhere((ic) => ic.id == bloc.state.selectedCategoryId!);
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemLabelCard(
                    nameTextController: nameController,
                    label: category.name,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  getItemDetailCard(category),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Divider(
                        indent: 10,
                        endIndent: 10,
                        thickness: 2,
                      )),
                      Text("Or", style: Theme.of(context).textTheme.titleLarge),
                      const Expanded(
                          child: Divider(
                        indent: 10,
                        endIndent: 10,
                        thickness: 2,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: ElevatedButton(
                          onPressed: () {
                            // bloc!
                            //     .addNavigatedEvent(NavigatorScannerPageEvent());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(5))),
                          child: const Text("Scan QR",
                              style: TextStyle(
                                  inherit: false, color: Colors.black)))),
                  const SizedBox(
                    height: 20,
                  ),
                ]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: toString(),
          onPressed: () {
            bloc.setItemInfo(SetItemInfoEvent(
                name: nameController.text,
                phoneNumber: phoneNumberController.text,
                message: messageController.text,
                url: urlController.text,
                address: addressController.text,
                bcc: bccController.text,
                cc: ccController.text,
                subject: subjectController.text,
                body: bodyController.text,
                networkName: networkNameController.text,
                password: passwordController.text));
          },
          child: const Icon(Icons.keyboard_double_arrow_right_rounded)),
    );
  }

  @override
  void dispose() {
    debugPrint("ItemContentSubPage dispose");
    nameController.dispose();
    phoneNumberController.dispose();
    messageController.dispose();
    urlController.dispose();

    addressController.dispose();
    bccController.dispose();
    ccController.dispose();
    subjectController.dispose();
    bodyController.dispose();

    networkNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
