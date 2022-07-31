import 'dart:convert';

import 'package:bike_shop_app/models/contact.dart';
import 'package:bike_shop_app/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel?>? _contactModel = [];
  List<ContactModel> get contactModel => List.unmodifiable(_contactModel!);

  final ApiService service = ApiService();
  late SharedPreferences contactPrefs;

  bool loading = false;

  Future<void> getContactList() async {
    loading = true;

    contactPrefs = await SharedPreferences.getInstance();

    List<ContactModel>? contactApi = await service.fetchAllContact();

    final encodedContactApi = contactApi!.map((item) => jsonEncode(ContactModel.toJson(item))).toList();
    final encodedContactModel = contactModel.map((item) => jsonEncode(ContactModel.toJson(item))).toList();

    final newList = {...encodedContactApi, ...encodedContactModel}.toList();
    final decodedNewList = newList.map((e) => ContactModel.fromJson(jsonDecode(e))).toList();

    _contactModel = decodedNewList;

    loading = false;

    notifyListeners();
  }

  Future<void> addContact(ContactModel contact) async {
    var postedContact = await service.postContact(contact);

    _contactModel!.add(postedContact);

    notifyListeners();
  }
}
