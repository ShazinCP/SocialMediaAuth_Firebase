import 'package:auth_app/constants/sizedbox.dart';
import 'package:auth_app/controller/auth_provider.dart';
import 'package:auth_app/controller/internet_provider.dart';
import 'package:auth_app/helper/colors.dart';
import 'package:auth_app/view/home_screen.dart';
import 'package:auth_app/widgets/next_screen.dart';
import 'package:auth_app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBlackColor,
      appBar: AppBar(
        backgroundColor: cLightBlackColorrr,
        title: const Text(
          "Auth App",
          style: TextStyle(
            color: cWhiteColor,
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<AuthProviders>(
        builder: (context, data, child) {
          return Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedLoadingButton(
                onPressed: () {
                  handleGoogleSignIn(context);
                },
                controller: data.googleController,
                successColor: cBlackColor,
                width: MediaQuery.of(context).size.width * 0.80,
                elevation: 0,
                borderRadius: 25,
                color: cWhiteColor,
                child: Wrap(
                  children: [
                    Image.asset("assets/google_icon.png", height: 25),
                    cWidth15,
                    const Text(
                      "Sign in with Google",
                      style: TextStyle(
                        color: cBlackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              cHeight30,
              RoundedLoadingButton(
                onPressed: () {},
                controller: data.facebookController,
                successColor: cDarkBlueColor,
                width: MediaQuery.of(context).size.width * 0.80,
                elevation: 0,
                borderRadius: 25,
                color: cDarkBlueColor,
                child: const Wrap(
                  children: [
                    Icon(
                      FontAwesomeIcons.facebook,
                      size: 20,
                      color: cWhiteColor,
                    ),
                    cWidth15,
                    Text(
                      "Sign in with Facebook",
                      style: TextStyle(
                        color: cWhiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              cHeight30,
              RoundedLoadingButton(
                onPressed: () {
                  data.signInWithGitHub();
                },
                controller: data.githubController,
                successColor: cLightBlackColor,
                width: MediaQuery.of(context).size.width * 0.80,
                elevation: 0,
                borderRadius: 25,
                color: cLightBlackColor,
                child: const Wrap(
                  children: [
                    Icon(
                      FontAwesomeIcons.github,
                      size: 20,
                      color: cWhiteColor,
                    ),
                    cWidth15,
                    Text(
                      "Sign in with GitHub",
                      style: TextStyle(
                        color: cWhiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // HANDLING GOOGLE SIGNIN IN
  Future handleGoogleSignIn(BuildContext context) async {
    final data = context.read<AuthProviders>();
    final network = context.read<InternetProvider>();
    await network.checkInternetConnection();

    if (network.hasInternet == false) {
      // ignore: use_build_context_synchronously
      openSnackBar(context, "Check your Internet connection", cRedColor);
      data.googleController.reset();
    } else {
      await data.signInWithGoogle().then((value) {
        if (data.hasError == true) {
          openSnackBar(context, data.errorCode.toString(), cRedColor);
          data.googleController.reset();
        } else {
          // CHECKING WHETHER USER EXISTS OR NOT
          data.checkUserExists().then((value) async {
            if (value == true) {
              // USER EXISTS
              await data.getUserDataFromFirestore(data.uid).then((value) => data
                  .saveDataToSharedPreferences()
                  .then((value) => data.setSignIn().then((value) {
                        data.googleController.success();
                        handleAfterSignIn(context);
                      })));
            } else {
              // USER DOES NOT EXIST
              data.saveDataToFirestore().then((value) => data
                  .saveDataToSharedPreferences()
                  .then((value) => data.setSignIn().then((value) {
                        data.googleController.success();
                        handleAfterSignIn(context);
                      })));
            }
          });
        }
      });
    }
  }

  // HANDLE AFTER SIGNIN
  handleAfterSignIn(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplace(context, const HomeScreen());
    });
  }
}
