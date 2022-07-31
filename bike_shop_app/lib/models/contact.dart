class ContactModel {
  final String name;
  final String number;

  ContactModel({required this.name, required this.number});

  factory ContactModel.fromJson(Map<String, dynamic> jsonData) {
    return ContactModel(
      name: jsonData['name'],
      number: jsonData['phone'],
    );
  }

  static Map<String, dynamic> toJson(ContactModel contact) => {'name': contact.name, 'phone': contact.number};    
}