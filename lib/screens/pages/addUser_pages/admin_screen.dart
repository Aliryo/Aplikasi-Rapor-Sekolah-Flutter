import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: const Text(
          'Daftar Admin',
          style: TextStyle(fontFamily: 'Montserrat Medium'),
        ),
        gradient: const LinearGradient(
            colors: [Colors.green, Colors.cyan, Colors.blue]),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('level', isEqualTo: 'Admin')
                    .snapshots(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> guruSnapshot) {
                  if (guruSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (guruSnapshot.hasError) {
                    return Center(
                      child: Text(guruSnapshot.error.toString()),
                    );
                  }

                  if (guruSnapshot.data != null) {
                    final documents = guruSnapshot.data!.docs;
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (ctx, index) {
                        return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              onTap: () {},
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage('assets/images/admin.png'),
                                  ),
                                ),
                              ),
                              title: Text(documents[index]['username'],
                                  style: GoogleFonts.poppins()),
                              subtitle: documents[index]['status'] == null
                                  ? null
                                  : Text(documents[index]['status'],
                                      style: GoogleFonts.poppins()),
                            ));
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Tidak Ada Data'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
