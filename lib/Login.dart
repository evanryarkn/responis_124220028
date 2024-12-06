import 'package:flutter/material.dart';
import 'package:responis_124220028/Register.dart';
import 'package:responis_124220028/ListMakanan.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? usnFromSession;
  String? passFromSession;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    loadSession();
  }

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      usnFromSession = prefs.getString('username');
      passFromSession = prefs.getString('password');
    });
  }

  void login(){
    if (_usernameController.text == usnFromSession && _passwordController.text == passFromSession) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('Login Berhasil'), backgroundColor: Colors.green,));
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CategoriesPage(username: '',)));

    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('Login Gagal'), backgroundColor: Colors.red,));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
              onPressed: login,
              child: const Text('Login'),
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
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}