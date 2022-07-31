import 'package:bike_shop_app/screens/auth/register_screen.dart';
import 'package:bike_shop_app/screens/auth/widgets/logo_widget.dart';
import 'package:bike_shop_app/screens/auth/widgets/logreg_button.dart';
import 'package:bike_shop_app/screens/auth/widgets/text_field.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:bike_shop_app/viewModels/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<AuthStateProvider>().changeState(AuthState.none);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor100,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: primaryColor100,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.05,
            MediaQuery.of(context).size.height * 0.1,
            MediaQuery.of(context).size.width * 0.05,
            0,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                logoWidget("assets/images/logo_widget.png"),
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
                _registerOption(),
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
        final isError = auth.viewState == AuthState.error;

        if (isLoading) {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          );
        }

        if (isError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Wrong username or password'),
              ),
            );
            auth.changeState(AuthState.none);
          });
        }

        return logregButton(
          context,
          true,
          () async {
            if (!formKey.currentState!.validate()) return;

            final String email = _emailController.text.trim();
            final String password = _passwordController.text.trim();
            await auth.login(email, password);
          },
        );
      },
    );
  }

  Widget _registerOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: subtitleTextStyle,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterScreen(),
              ),
            );
          },
          child: Text(
            'Sign Up',
            style: buttonTextStyle.copyWith(color: colorYellow),
          ),
        )
      ],
    );
  }
}
