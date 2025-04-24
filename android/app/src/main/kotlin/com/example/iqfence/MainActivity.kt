package com.example.iqfence

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity()

FirebaseAuth auth = FirebaseAuth.getInstance();
FirebaseDatabase database = FirebaseDatabase.getInstance();

// Fungsi Register
private void registerUser(String email, String password, String name) {
    FirebaseAuth auth = FirebaseAuth.getInstance();
    auth.createUserWithEmailAndPassword(email, password)
        .addOnCompleteListener(task -> {
            if (task.isSuccessful()) {
                // Simpan data pengguna ke Realtime Database
                String userId = auth.getCurrentUser().getUid();
                DatabaseReference usersRef = FirebaseDatabase.getInstance().getReference("users");
                usersRef.child(userId).setValue(new User(name, email));
                Toast.makeText(this, "Registrasi berhasil!", Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(this, "Registrasi gagal: " + task.getException().getMessage(), Toast.LENGTH_SHORT).show();
            }
        });
}