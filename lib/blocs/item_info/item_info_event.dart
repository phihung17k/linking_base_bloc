import 'package:equatable/equatable.dart';

abstract class ItemInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetItemInfoEvent {
  final String? name;
  final String? phoneNumber;
  final String? message;
  final String? url;

  final String? address;
  final String? cc;
  final String? bcc;
  final String? subject;
  final String? body;

  final String? networkName;
  final String? password;

  SetItemInfoEvent(
      {this.name,
      this.phoneNumber,
      this.message,
      this.url,
      this.address,
      this.cc,
      this.bcc,
      this.subject,
      this.body,
      this.networkName,
      this.password});
}

class BackingHomePageEvent extends ItemInfoEvent {
  final bool isSuccess;

  BackingHomePageEvent(this.isSuccess);
}