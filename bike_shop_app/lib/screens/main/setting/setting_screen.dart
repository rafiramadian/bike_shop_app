import 'package:bike_shop_app/models/user.dart';
import 'package:bike_shop_app/screens/landing/wrapper.dart';
import 'package:bike_shop_app/services/auth_service.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:bike_shop_app/viewModels/user_app_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: context.read<UserAppProvider>().userApp,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final image = snapshot.data!['image'];
          final String username = snapshot.data!['username'];
          final String email = snapshot.data!['email'];
          final String password = snapshot.data!['password'];

          String usernameForm = '';
          String emailForm = '';

          return Center(
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: primaryColor100, width: 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 2.5,
                    color: colorWhite,
                    shadowColor: primaryColor500,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 60.0, bottom: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: darkBlue500),
                              shape: BoxShape.circle,
                              color: darkBlue500,
                            ),
                            child: image != ""
                                ? Image.asset(image)
                                : const Icon(
                                    Icons.person,
                                    color: colorWhite,
                                  ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            username,
                            style: titleTextStyle,
                          ),
                          Text(
                            email,
                            style: subtitleTextStyle,
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: colorYellow,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.custom,
                                      barrierDismissible: true,
                                      confirmBtnText: 'Save',
                                      cancelBtnText: 'Cancel',
                                      widget: Column(
                                        children: [
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              hintText: 'New Username',
                                              prefixIcon: Icon(
                                                Icons.person,
                                              ),
                                            ),
                                            textInputAction: TextInputAction.done,
                                            keyboardType: TextInputType.name,
                                            onChanged: (value) {
                                              setState(() {
                                                usernameForm = value;
                                              });
                                            },
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              hintText: 'New Email',
                                              prefixIcon: Icon(
                                                Icons.email,
                                              ),
                                            ),
                                            textInputAction: TextInputAction.send,
                                            keyboardType: TextInputType.emailAddress,
                                            onChanged: (value) {
                                              setState(() {
                                                emailForm = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      onCancelBtnTap: () {
                                        Navigator.pop(context);
                                      },
                                      onConfirmBtnTap: () async {
                                        if (usernameForm.isEmpty || emailForm.isEmpty) {
                                          await CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: 'Field tidak boleh kosong',
                                          );
                                          return;
                                        }

                                        final userApp = UserApp(
                                          username: usernameForm,
                                          email: emailForm,
                                          password: password,
                                          image: "",
                                        );

                                        final message = await context.read<UserAppProvider>().updateProfile(userApp);
                                        await context.read<AuthService>().updateEmail(email, password, emailForm);

                                        if (message != 'Success') {
                                          await Future.delayed(const Duration(milliseconds: 1000));
                                          await CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Kesalahan Jaringan!",
                                          );
                                          return;
                                        }

                                        Navigator.pop(context);
                                        await Future.delayed(const Duration(milliseconds: 1000));
                                        await CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.success,
                                          text: "Profile has been saved!.",
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(Icons.edit),
                                ),
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: primaryColor100,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    await context.read<AuthService>().logout();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Wrapper(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  child: const Icon(Icons.logout),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: darkBlue500,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'PROFILE',
                        style: titleTextStyle.copyWith(color: colorWhite),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
