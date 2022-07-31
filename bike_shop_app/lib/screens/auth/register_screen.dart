import 'package:bike_shop_app/models/user.dart';
import 'package:bike_shop_app/screens/auth/widgets/logreg_button.dart';
import 'package:bike_shop_app/screens/auth/widgets/text_field.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:bike_shop_app/viewModels/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: primaryColor100,
      appBar: AppBar(
        foregroundColor: darkBlue500,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Sign Up',
          style: titleTextStyle,
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor100,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.05,
            MediaQuery.of(context).size.height * 0.15,
            MediaQuery.of(context).size.width * 0.05,
            0,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                textField(
                  'Enter Username',
                  Icons.person,
                  false,
                  _usernameController,
                ),
                const SizedBox(
                  height: 8,
                ),
                textField(
                  'Enter Email',
                  Icons.email,
                  false,
                  _emailController,
                ),
                const SizedBox(
                  height: 8,
                ),
                textField(
                  'Enter Password',
                  Icons.lock,
                  true,
                  _passwordController,
                ),
                _buildViewStateButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewStateButton() {
    return Consumer<AuthStateProvider>(
      builder: (context, auth, _) {
        final isLoading = auth.viewState == AuthState.loading;
        final error = auth.viewState == AuthState.error;
        String? message;

        if (isLoading) {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          );
        }

        if (error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message ?? 'There is already account with this email address'),
              ),
            );
            auth.changeState(AuthState.none);
          });
        }

        return logregButton(
          context,
          false,
          () async {
            if (!formKey.currentState!.validate()) return;

            final String username = _usernameController.text.trim();
            final String email = _emailController.text.trim();
            final String password = _passwordController.text.trim();

            final userApp = UserApp(
              username: username,
              email: email,
              password: password,
              image: "",
            );

            message = await auth.signUp(userApp);

            if (message == 'Success') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('SignUp Successfull')),
              );
              Navigator.pop(context);
              return;
            }

            auth.changeState(AuthState.error);
          },
        );
      },
    );
  }
}
