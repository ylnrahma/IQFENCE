import 'package:flutter/material.dart';

// Forgot Password Page
class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lupa Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Masukkan email Anda untuk mereset password.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Logic untuk mengirim email reset password
                print('Email reset dikirim ke: ${emailController.text}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Email reset password telah dikirim!')),
                );
              },
              child: Text('Kirim Email Reset'),
            ),
          ],
        ),
      ),
    );
  }
}