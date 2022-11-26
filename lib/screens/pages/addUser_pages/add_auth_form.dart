import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAuthForm extends StatefulWidget {
  const AddAuthForm({Key? key, required this.submitAuthFormFn})
      : super(key: key);
  final Function({
    required String email,
    required String username,
    required String status,
    required String password,
    required String level,
  }) submitAuthFormFn;

  @override
  State<AddAuthForm> createState() => _AddAuthFormState();
}

class _AddAuthFormState extends State<AddAuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _passwordVisibility = true;
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _statusController = TextEditingController();
  final _passwordController = TextEditingController();

  String _email = '';
  String _username = '';
  String _status = '';
  String _password = '';
  String _level = 'Admin';

  void submitForm() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        widget.submitAuthFormFn(
          email: _email,
          username: _username,
          status: _status,
          password: _password,
          level: _level,
        );
      }
    }
    _emailController.text = '';
    _usernameController.text = '';
    _statusController.text = '';
    _passwordController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(children: [
              TextFormField(
                controller: _emailController,
                key: const Key('email'),
                style: GoogleFonts.poppins(),
                decoration: const InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      EmailValidator.validate(value) == false) {
                    return 'Format Email Salah';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value ?? '';
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _usernameController,
                key: const Key('username'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z,.]'))
                ],
                style: GoogleFonts.poppins(),
                decoration: const InputDecoration(
                    labelText: 'Nama Lengkap', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 4) {
                    return 'Nama Lengkap Minimal 4 Karakter';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value ?? '';
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _statusController,
                key: const Key('status'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                ],
                style: GoogleFonts.poppins(),
                decoration: const InputDecoration(
                    labelText: 'Status / Jabatan',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Status / Jabatan';
                  }
                  return null;
                },
                onSaved: (value) {
                  _status = value ?? '';
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordController,
                key: const Key('password'),
                style: GoogleFonts.poppins(),
                obscureText: _passwordVisibility,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_passwordVisibility == true) {
                              _passwordVisibility = false;
                            } else {
                              _passwordVisibility = true;
                            }
                          });
                        },
                        child: _passwordVisibility
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    labelText: 'Password',
                    border: const OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Password Minimal 6 Karakter';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value ?? '';
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Pilih Level Akun:',
                style: GoogleFonts.poppins(),
              ),
              Container(
                key: const Key('level'),
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _level,
                  elevation: 12,
                  onChanged: (String? value) {
                    setState(() {
                      _level = value!;
                    });
                  },
                  items: <String>['Admin', 'Guru']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.poppins(),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: 220,
                height: 55,
                child: TextButton(
                  onPressed: submitForm,
                  child: Text(
                    'Daftar',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
