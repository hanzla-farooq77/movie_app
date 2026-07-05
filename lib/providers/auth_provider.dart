import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/services/auth_service.dart';

final AuthProvider = Provider<AuthService>((ref){
  return AuthService();
});
