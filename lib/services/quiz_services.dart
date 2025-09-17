import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuizServices {
  Future<void>saveQuiz(bool quiz) async {
    try {
      final docRef = await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('quiz')
          .doc('quizResult');

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.set({
          'kondisi': quiz ? 'true' : 'false',
        });
      } else {
        await docRef.set({

          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    }catch(e){

    }
  }
}