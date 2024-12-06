import 'package:flutter/material.dart';
import 'package:responis_124220028/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController= TextEditingController();

  // Fungsi untuk register akun kedalam shared preferences
  Future<void> _registerSharedPref () async {
    final prefs = await SharedPreferences.getInstance();
    // Masukkan nilai ke sharedpref
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('password', _passwordController.text);
  }

  // Fungsi yang dipanggil ketika register
  void _register (){
    // Simpan kedalam shared pref
    _registerSharedPref();
    // tampilan snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('Register Berhasil'), backgroundColor: Colors.green,));
    // Mengarahkan ke login
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text('Belum punya akun? Daftar'),
            ),
            
          ],
        ),
      ),
    );
  }
}