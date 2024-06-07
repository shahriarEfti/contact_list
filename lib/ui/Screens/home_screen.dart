import 'package:contact_list/ui/Widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:contact_list/ui/Widgets/contact_tile.dart'; // Import the new widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameTEcontroller = TextEditingController();
  final TextEditingController _numberTEcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  List<Map<String, String>> _contacts = [];
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  void _addContact() {
    setState(() {
      _autovalidateMode = AutovalidateMode.onUserInteraction;
    });

    if (_formkey.currentState!.validate()) {
      setState(() {
        _contacts.add({
          'name': _nameTEcontroller.text,
          'number': _numberTEcontroller.text,
        });
        _nameTEcontroller.clear();
        _numberTEcontroller.clear();
        _autovalidateMode = AutovalidateMode.disabled;
      });
    }
  }

  void _deleteContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  Future<void> _showDeleteConfirmationDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure for delete ?'),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.no_sim_outlined, color: Colors.grey),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.blue),
              onPressed: () {
                _deleteContact(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameTEcontroller.dispose();
    _numberTEcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Contact List"),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formkey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            children: [
              TextFormField(
                controller: _nameTEcontroller,
                decoration: InputDecoration(
                  hintText: "Name",
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Please enter the Name";
                  }
                  return null;
                },
              ),
              const Gap(10),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: _numberTEcontroller,
                decoration: InputDecoration(
                  hintText: "Number",
                  labelText: "Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Please enter the Number";
                  }
                  return null;
                },
              ),
              const Gap(20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: _addContact,
                  child: const Text("Add"),
                ),
              ),
              const Gap(20),
              Expanded(
                child: ListView.separated(
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) {
                    return ContactTile(
                      name: _contacts[index]['name']!,
                      number: _contacts[index]['number']!,
                      onLongPress: () {
                        _showDeleteConfirmationDialog(index);
                      },
                      onCallPressed: () {
                        // Handle call action
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey[400],
                      height: 1,
                      thickness: 1,
                      indent: 16,
                      endIndent: 16,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
