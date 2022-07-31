import 'package:bike_shop_app/viewModels/contact_manager.dart';
import 'package:flutter/material.dart';

class ContactListScreen extends StatelessWidget {
  final ContactProvider manager;
  final _controller = ScrollController();

  ContactListScreen({Key? key, required this.manager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactItem = manager.contactModel;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        controller: _controller,
        itemCount: contactItem.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(contactItem[index].name.substring(0, 1)),
            ),
            title: Text(contactItem[index].name),
            subtitle: Text(contactItem[index].number),
            trailing: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: const Text('Are you sure want to delete this contact?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No')),
                              TextButton(
                                  onPressed: () {
                                    // manager.deleteContact(contactItem[index]);
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Delete ${contactItem[index].name} Successfully!')),
                                    );
                                  },
                                  child: const Text('Yes')),
                            ],
                          ));
                },
                icon: const Icon(Icons.delete_forever_rounded)),
          );
        },
      ),
    );
  }
}
