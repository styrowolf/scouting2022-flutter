import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapid_react_scouting/main.dart';

class LoginRegisterScreen extends ConsumerWidget {
  const LoginRegisterScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(rrsStateProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome to Rapid React Scouting!',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 16),
          const Card(
            child: LoginRegisterForm(),
          )
        ],
      ),
    );
  }
}

class LoginRegisterForm extends ConsumerStatefulWidget {
  const LoginRegisterForm({Key? key}): super(key: key);

  @override
  ConsumerState<LoginRegisterForm> createState() => _LoginRegisterFormState();
}

class _LoginRegisterFormState extends ConsumerState<LoginRegisterForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(rrsStateProvider.notifier);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ 
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Email')
              ),
              validator: (value) {
                if (value != null && !EmailValidator.validate(value)) {
                  if (value != "") {
                    return 'The empty string is not a valid email.';
                  } else {
                    return '$value is not a valid email.';
                  }
                }
              },
              controller: emailController,
            ),
            const SizedBox(height: 8,),
            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              decoration: const InputDecoration(
                label: Text('Password')
              ),
              controller: passwordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await notifier.login(email: emailController.text, password: passwordController.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(
                        emailController.text == '' ? 'The empty string is not a valid email.' : '${emailController.text} is not a valid email.'))
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await notifier.register(email: emailController.text, password: passwordController.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${emailController.text} is not a valid email.'))
                    );
                  }
                }, 
                child: const Text('Register'),
              ),
            ),
          ],
        )
      )
    );
  }
}