import 'package:bike_shop_app/models/contact.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiService {
  final Dio _dio = Dio();

  final String _baseUrl = 'https://my-json-server.typicode.com/hadihammurabi/flutter-webservice/';

  Future<List<ContactModel>?> fetchAllContact() async {
    List<ContactModel>? contacts;

    try {
      final response = await _dio.get(_baseUrl + 'contacts');

      if (response.statusCode == 200) {
        var data = response.data as List<dynamic>;
        contacts = data.map((e) => ContactModel.fromJson(e)).toList();
      } else {
        contacts = [];
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
    }
    return contacts;
  }

  Future<ContactModel?> postContact(ContactModel contact) async {
    ContactModel? postedContact;

    var data = ContactModel.toJson(contact);

    try {
      final response = await _dio.post(_baseUrl + "contacts", data: data);

      if (response.statusCode == 201) {
        postedContact = ContactModel.fromJson(response.data);
      } else {
        postedContact = null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
    }
    return postedContact;
  }
}
