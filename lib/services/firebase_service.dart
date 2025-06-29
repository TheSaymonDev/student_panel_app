import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

import 'package:student_panel/screens/leaderboard_screen/models/leaderboard_user_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Read Classes for Registration
  Future<Map<String, dynamic>> readClasses() async {
    try {
      final querySnapshot = await _firestore.collection("classes").get();

      return {
        'success': true,
        'data': querySnapshot,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to read classes: ${e.toString()}',
      };
    }
  }

  /// User Registration with Email & Password
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
    required String schoolName,
    required String className,
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
  Future<Map<String, dynamic>> completeRegistration({
    required String name,
    required String email,
    required String schoolName,
    required String className,
  }) async {
    try {
      final currentUser = _auth.currentUser;
      await currentUser?.reload();
      final refreshedUser = _auth.currentUser;

      // Step 1: Verify email
      if (refreshedUser == null || !refreshedUser.emailVerified) {
        return {
          'success': false,
          'message': 'Email is not verified. Please verify your email',
        };
      }

      // Step 2: Validate className and classCode
      final query = await _firestore
          .collection('classes')
          .where('className', isEqualTo: className)
          .get();

      if (query.docs.isEmpty) {
        return {
          'success': false,
          'message': 'Invalid class name. Please check and try again.',
        };
      }

      final classDoc = query.docs.first;
      await _firestore
          .collection('classes')
          .doc(classDoc.id)
          .collection('users')
          .doc(refreshedUser.uid)
          .set(
        {
          'userId': refreshedUser.uid,
          'name': name,
          'email': email,
          'schoolName': schoolName,
          'className': className,
          'joinedAt': FieldValue.serverTimestamp(),
        },
      );

      return {
        'success': true,
        'message': 'Registration completed successfully and added to class!',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to complete registration: ${e.toString()}',
      };
    }
  }

  /// Resend Link For Email Verification
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
        'message':
            'Password reset email sent successfully. Please check your inbox.',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to send reset email: ${e.toString()}',
      };
    }
  }

  /// User Log In with Email & Password
  Future<dynamic> logIn({
    required String email,
    required String password,
  }) async {
    try {
      // Authenticate user
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userId = userCredential.user?.uid;

      if (userId == null || userId.isEmpty) {
        return {
          'success': false,
          'message': 'User ID not found',
        };
      }

      // Query to find the class containing this user
      final classesQuery = await _firestore.collection('classes').get();

      String? classId;
      for (var classDoc in classesQuery.docs) {
        final userDoc =
            await classDoc.reference.collection('users').doc(userId).get();
        if (userDoc.exists) {
          classId = classDoc.id;
          break;
        }
      }

      if (classId == null) {
        return {
          'success': false,
          'message': 'No class found for this user!',
        };
      }

      return {
        'success': true,
        'userId': userId,
        'classId': classId,
        'message': 'Login successful!',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Login failed: ${e.toString()}',
      };
    }
  }

  /// Read Current User data
  Future<dynamic> readCurrentUserData(
      {required String classId, required String userId}) async {
    try {
      final userId = _auth.currentUser!.uid;
      final data = await _firestore
          .collection('classes')
          .doc(classId)
          .collection('users')
          .doc(userId)
          .get();
      return {
        'success': true,
        'data': data,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to read user data: ${e.toString()}',
      };
    }
  }

  /// Read Subjects From Firestore
  Future<Map<String, dynamic>> readSubjects({required String classId}) async {
    try {
      final querySnapshot = await _firestore
          .collection("classes")
          .doc(classId)
          .collection("subjects")
          .get();

      return {
        'success': true,
        'data': querySnapshot,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to read subjects: ${e.toString()}',
      };
    }
  }

  /// Read Quizzes From Firestore
  Future<Map<String, dynamic>> readQuizzes({
    required String classId,
    required String subjectId,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection("classes")
          .doc(classId)
          .collection("subjects")
          .doc(subjectId)
          .collection("quizzes")
          .get();

      return {
        'success': true,
        'data': querySnapshot,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to read quizzes: ${e.toString()}',
      };
    }
  }

  /// Submit quiz result to Firestore
  Future<dynamic> submitQuizResult({
    required String classId,
    required String userId,
    required String subjectName,
    required String topicName,
    required int totalQuestions,
    required int correctAnswers,
    required String quizId,
  }) async {
    try {
      double percentage = (correctAnswers / totalQuestions) * 100;

      await FirebaseFirestore.instance
          .collection('classes')
          .doc(classId)
          .collection('users')
          .doc(userId)
          .collection('results')
          .add({
        'subjectName': subjectName,
        'topicName': topicName,
        'totalQuestions': totalQuestions,
        'correctAnswers': correctAnswers,
        'scorePercentage': percentage,
        'quizId': quizId,
        'attemptedAt': FieldValue.serverTimestamp(),
      });

      return {
        'success': true,
        'message': 'Result submitted successfully!',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to submit result: ${e.toString()}',
      };
    }
  }

  /// Read results from firestore
  Future<dynamic> readResults({
    required String classId,
    required String userId,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection('classes')
          .doc(classId)
          .collection('users')
          .doc(userId)
          .collection('results')
          .orderBy('attemptedAt', descending: true) // latest first
          .get();

      return {
        'success': true,
        'data': querySnapshot,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to read results: ${e.toString()}',
      };
    }
  }

  /// Read results from firestore
  Future<dynamic> readRecentResults({
    required String classId,
    required String userId,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection('classes')
          .doc(classId)
          .collection('users')
          .doc(userId)
          .collection('results')
          .orderBy('attemptedAt', descending: true)
          .limit(5) // latest 5 results
          .get();

      return {
        'success': true,
        'data': querySnapshot,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to read results: ${e.toString()}',
      };
    }
  }

  // Read Leaderboard Data to Firebase
  Future<Map<String, dynamic>> readLeaderboardData({
    required String classId,
    required String filter,
  }) async {
    try {
      print('Start reading leaderboard data for classId: $classId and filter: $filter');

      final usersSnapshot = await _firestore
          .collection('classes')
          .doc(classId)
          .collection('users')
          .get();

      print('Total users found: ${usersSnapshot.docs.length}');

      DateTime now = DateTime.now();
      DateTime startDate;

      if (filter == 'today') {
        startDate = DateTime(now.year, now.month, now.day);
      } else if (filter == 'week') {
        startDate = now.subtract(Duration(days: now.weekday - 1));
      } else if (filter == 'month') {
        startDate = DateTime(now.year, now.month, 1);
      } else {
        startDate = DateTime(2000);
      }

      print('Start date for filter "$filter": $startDate');

      List<LeaderboardUserModel> leaderboard = [];

      for (final userDoc in usersSnapshot.docs) {
        final userId = userDoc.id;
        final username = userDoc.data()['name'] ?? 'Unknown';
        final photoUrl = userDoc.data()['photoUrl'] ?? '';

        print('Processing user: $username ($userId)');

        final resultsSnapshot = await _firestore
            .collection('classes')
            .doc(classId)
            .collection('users')
            .doc(userId)
            .collection('results')
            .where('attemptedAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
            .get();

        print('  → Results found: ${resultsSnapshot.docs.length}');

        double totalScore = 0;
        for (final doc in resultsSnapshot.docs) {
          final score = (doc.data()['correctAnswers'] ?? 0).toDouble();
          print('    → Score: $score');
          totalScore += score;
        }

        leaderboard.add(LeaderboardUserModel(
          userId: userId,
          username: username,
          totalScore: totalScore.toInt(),
        ));
      }

      leaderboard.sort((a, b) => b.totalScore.compareTo(a.totalScore));
      print('Leaderboard sorted, total entries: ${leaderboard.length}');

      return {
        'success': true,
        'data': leaderboard,
      };
    } catch (e) {
      print('Exception: $e');
      return {
        'success': false,
        'message': 'Failed to fetch leaderboard: ${e.toString()}'
      };
    }
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
