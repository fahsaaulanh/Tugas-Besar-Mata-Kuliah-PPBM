import 'package:chat_app/service/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = _authService.getCurrentUser();
  }

  // Fungsi untuk menambah kontak baru
  Future<void> _addContact(String name, String phone) async {
    if (currentUser == null) return;

    final contact = {
      'name': name,
      'phone': phone,
      'userId': currentUser!.uid,
    };

    await _firestore.collection('contacts').add(contact);
  }

  // Fungsi untuk memperbarui kontak
  Future<void> _updateContact(String id, String name, String phone) async {
    if (currentUser == null) return;

    final updatedContact = {
      'name': name,
      'phone': phone,
    };

    await _firestore.collection('contacts').doc(id).update(updatedContact);
  }

  // Fungsi untuk menghapus kontak
  Future<void> _deleteContact(String id) async {
    if (currentUser == null) return;

    await _firestore.collection('contacts').doc(id).delete();
  }

  // Menampilkan dialog tambah/edit kontak
  void _showContactDialog(
      {String? id, String? initialName, String? initialPhone}) {
    final TextEditingController nameController =
        TextEditingController(text: initialName);
    final TextEditingController phoneController =
        TextEditingController(text: initialPhone);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Mengatur border radius
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // Lebar 80% layar
            constraints: const BoxConstraints(
              maxHeight: 400, // Tinggi maksimum 400px
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  id == null ? 'Add Contact' : 'Update Contact',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: 'name',
                      hintStyle: TextStyle(color: Color(0xFFB9B6B9))),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                      hintText: 'phone number',
                      hintStyle: TextStyle(color: Color(0xFFB9B6B9))),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final name = nameController.text.trim();
                        final phone = phoneController.text.trim();

                        if (name.isEmpty || phone.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fill all fields')),
                          );
                          return;
                        }

                        if (id == null) {
                          _addContact(name, phone);
                        } else {
                          _updateContact(id, name, phone);
                        }

                        Navigator.of(context).pop();
                      },
                      child: Text(id == null ? 'Add' : 'Update'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return const Center(child: Text('No user logged in'));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF7893FF),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: Container(
          color: Color(0xFFE9E6F7),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('contacts')
                  .where('userId', isEqualTo: currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading contacts'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No contacts found'));
                }

                final contacts = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final doc = contacts[index];
                    final data = doc.data() as Map<String, dynamic>;

                    // Ambil inisial dari nama (huruf pertama)
                    final String initials = data['name'].isNotEmpty
                        ? data['name'][0].toUpperCase()
                        : '?';

                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                const Color(0xFFF84669), // Warna latar avatar
                            child: Text(
                              initials, // Inisial dari nama
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(data['name']),
                          subtitle: Text(data['phone']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    color: Color(0xFF7893FF)),
                                onPressed: () {
                                  _showContactDialog(
                                    id: doc.id,
                                    initialName: data['name'],
                                    initialPhone: data['phone'],
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Color(0xFFF84669)),
                                onPressed: () => _deleteContact(doc.id),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey,
                          indent: 16, // Jarak divider dari kiri
                          endIndent: 16, // Jarak divider dari kanan
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showContactDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
