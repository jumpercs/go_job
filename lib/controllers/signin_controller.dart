import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseControllers {
  Future<void> signIn(String email, String password) async {
    // Create a local instance of Firebase
    FirebaseApp localApp = await Firebase.initializeApp(
      name: 'Local',
      options: Firebase.app().options,
    );

    try {
      FirebaseAuth localAuth = FirebaseAuth.instanceFor(app: localApp);

      UserCredential userCredential =
          await localAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      bool isVerified = userDoc['isVerified'];

      if (!isVerified) {
        throw FirebaseAuthException(
            message: 'Your account is still being verified. Please wait.',
            code: 'account-not-verified');
      }

      // If the user is verified, sign in with the global instance
      await localApp.delete();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      await localApp.delete();
      rethrow;
    }
  }
}
