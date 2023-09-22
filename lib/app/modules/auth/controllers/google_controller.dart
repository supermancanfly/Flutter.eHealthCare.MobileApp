import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../services/auth_service.dart';
import '../../../models/user_model.dart';
import '../../../repositories/user_repository.dart';
import '../../root/controllers/root_controller.dart';
import '../../../routes/app_routes.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class GoogleSignInProvider extends ChangeNotifier {
  final Rx<User> currentUser = Get.find<AuthService>().user;
  final loading = false.obs;
  UserRepository _userRepository;

  GoogleSignInProvider() {
    _userRepository = UserRepository();
  }

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount _user;
  GoogleSignInAccount get user => _user;

  Future googleLogin() async {
    loading.value = true;
    try{
      await googleSignIn.signOut();
      final googleUser = await googleSignIn.signIn();

      if(googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.accessToken,
      //   idToken: googleAuth.idToken,
      // );
      // await FirebaseAuth.instance.signInWithCredential(credential);

      currentUser.value.email = _user.email;
      currentUser.value.name = _user.displayName;
      currentUser.value.password = "googleuserpassword";
      currentUser.value.phoneNumber = "";

      currentUser.value = await _userRepository.googlelogin(currentUser.value);
      await Get.find<RootController>().changePage(0);

    } catch (e) {
      print(e.toString());
    }finally {
      loading.value = false;
    }
    notifyListeners();
  }

  Future logout () async {
    await googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
    _user = null;
    currentUser.value = null;
    RouteSettings(name: Routes.LOGIN);
    // FirebaseAuth.instance.signOut();
  }
}