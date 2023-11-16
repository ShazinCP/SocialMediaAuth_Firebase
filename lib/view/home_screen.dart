import 'package:auth_app/controller/auth_provider.dart';
import 'package:auth_app/helper/colors.dart';
import 'package:auth_app/view/login_screen.dart';
import 'package:auth_app/widgets/next_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future getData() async {
    final value = context.read<AuthProviders>();
    value.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // change read to watch!!!!
    final value = context.watch<AuthProviders>();
    return Scaffold(
      backgroundColor: cBlackColor,
      appBar: AppBar(
        backgroundColor: cLightBlackColorrr,
        title: const Text(
          "Home Screen",
          style: TextStyle(
            color: cWhiteColor,
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: cWhiteColor,
              backgroundImage: NetworkImage("${value.imageUrl}"),
              radius: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Welcome ${value.name}",
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: cWhiteColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${value.email}",
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: cWhiteColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${value.uid}",
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: cWhiteColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "PROVIDER:",
                  style: TextStyle(color: cGreyColor),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text("${value.provider}".toUpperCase(),
                    style: const TextStyle(color: cRedColor)),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  value.userSignOut();
                  nextScreenReplace(context, const LoginScreen());
                },
                child: const Text("SIGNOUT",
                    style: TextStyle(
                      color: cBlackColor,
                      fontWeight: FontWeight.bold,
                    )))
          ],
        ),
      ),
    );
  }
}
