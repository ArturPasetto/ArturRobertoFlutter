import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Banco{

  static final FirebaseAuth FIREBASE_AUTH = FirebaseAuth.instance;
  final CollectionReference usuarioCollection = FirebaseFirestore.instance.collection('usuario');

}