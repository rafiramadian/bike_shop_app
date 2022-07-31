import 'package:bike_shop_app/screens/main/home/contact_api/add_contact_screen.dart';
import 'package:bike_shop_app/screens/main/home/contact_api/contact_list_screen.dart';
import 'package:bike_shop_app/viewModels/contact_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'empty_screen.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  void initState() {
    super.initState();
    final manager = Provider.of<ContactProvider>(context, listen: false);
    manager.getContactList();
  }

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<ContactProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
      ),
      body: manager.loading ? const Center(child: CircularProgressIndicator()) : buildContactScreen(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final manager = Provider.of<ContactProvider>(context, listen: false);

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddContactScreen(onCreate: (contact) {
                      manager.addContact(contact);
                      Navigator.pop(context);
                      manager.getContactList();
                    })),
          );
        },
      ),
    );
  }

  Widget buildContactScreen() {
    final manager = Provider.of<ContactProvider>(context, listen: true);
    if (manager.contactModel.isNotEmpty) {
      return ContactListScreen(manager: manager);
    } else {
      return const EmptyScreen();
    }
  }
}
