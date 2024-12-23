import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// User Registration with Email & Password
  Future<dynamic> register({
    required String email,
    required String password,
    required String name,
    required String schoolName,
    required String className,
    required String classCode,
  }) async {
    try {
      // Step 1: Create user in Firebase Authentication
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Step 2: Send Email Verification
      await userCredential.user?.sendEmailVerification();

      return {
        'success': true,
        'message':
            'Registration successful! Please verify your email to complete registration',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Registration failed: ${e.toString()}',
      };
    }
  }

  /// Complete Registration after Email Verification
  Future<dynamic> completeRegistration({
    required String name,
    required String email,
    required String schoolName,
    required String className,
    required String classCode,
  }) async {
    try {
      final currentUser = _auth.currentUser;
      await currentUser?.reload();
      final refreshedUser = _auth.currentUser;
      if (refreshedUser == null || !refreshedUser.emailVerified) {
        return {
          'success': false,
          'message': 'Email is not verified. Please verify your email',
        };
      }
      await _firestore.collection('users').doc(refreshedUser.uid).set({
        'name': name,
        'email': email,
        'schoolName': schoolName,
        'className': className,
        'classCode': classCode,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return {
        'success': true,
        'message': 'Registration completed successfully!',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to complete registration: ${e.toString()}',
      };
    }
  }

  Future<dynamic> resendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
        return {
          'success': true,
          'message': 'Verification email sent successfully',
        };
      } catch (e) {
        return {
          'success': false,
          'message': 'Failed to send verification email: ${e.toString()}',
        };
      }
    }
  }

  /// Password Reset
  Future<dynamic> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return {
        'success': true,
        'message': 'Password reset email sent successfully. Please check your inbox.',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to send reset email: ${e.toString()}',
      };
    }
  }

  /// User Sign In with Email & Password
  Future<dynamic> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return {
        'success': true,
        'data': userCredential.user,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Login failed: ${e.toString()}',
      };
    }
  }

  /// Get Current User
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      developer.log("SignOut Error: $e");
    }
  }
}
