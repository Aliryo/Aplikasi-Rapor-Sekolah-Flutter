import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key, required this.submitAuthFormFn}) : super(key: key);
  final Function({
    required String email,
    required String username,
    required String password,
    required String nisn,
    required String level,
    required String status,
    required String kelas,
    required bool isLogin,
  }) submitAuthFormFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  var _passwordVisibility = true;

  String _email = '';
  String _username = '';
  String _password = '';
  String _nisn = '';
  String _kelas = 'Kelas 1';

  void submitForm() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        widget.submitAuthFormFn(
            email: _email,
            username: _username,
            password: _password,
            nisn: _nisn,
            level: 'Siswa',
            status: '',
            kelas: _kelas,
            isLogin: _isLogin);
      }
    }
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
              if (!_isLogin)
                TextFormField(
                  key: const Key('username'),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
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
              if (!_isLogin)
                const SizedBox(
                  height: 20,
                ),
              TextFormField(
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
              if (!_isLogin)
                TextFormField(
                  maxLength: 10,
                  key: const Key('nisn'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.poppins(),
                  decoration: const InputDecoration(
                      labelText: 'NISN', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length != 10) {
                      return 'NISN Berisi 10 Karakter';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nisn = value ?? '';
                  },
                ),
              if (!_isLogin)
                const SizedBox(
                  height: 20,
                ),
              if (!_isLogin)
                Text(
                  'Pilih Kelas:',
                  style: GoogleFonts.poppins(),
                ),
              if (!_isLogin)
                Container(
                  key: const Key('kelas'),
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _kelas,
                    elevation: 12,
                    onChanged: (String? value) {
                      setState(() {
                        _kelas = value!;
                      });
                    },
                    items: <String>[
                      'Kelas 1',
                      'Kelas 2',
                      'Kelas 3',
                      'Kelas 4',
                      'Kelas 5',
                      'Kelas 6',
                    ].map<DropdownMenuItem<String>>((String value) {
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
              if (!_isLogin)
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
                    _isLogin ? 'Masuk' : 'Daftar',
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
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(
                _isLogin ? 'Daftar Siswa Baru' : 'Sudah Punya Akun',
                style: GoogleFonts.poppins(
                  color: Colors.blueGrey,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
