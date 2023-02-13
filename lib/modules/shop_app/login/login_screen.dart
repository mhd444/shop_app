import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layouts/shop_app/shop_layout.dart';
import 'package:my_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:my_app/modules/shop_app/login/cubit/states.dart';
import 'package:my_app/modules/shop_app/register/register_screen.dart';
import 'package:my_app/shared/components/components.dart';
import 'package:my_app/shared/components/constants.dart';
import 'package:my_app/shared/network/local/cash_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessStates) {
            if (state.loginModel.status) {
              CashHelper.saveData(
                      key: 'token',
                  value: state.loginModel.data.token)
                  .then((value) {
                    token = state.loginModel.data.token;
                navigateAndFinish(context, const ShopLayout());
              });
            } else {
              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Login now to brows our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                              label: Text('Email Address'),
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 1.0,
                                      color: Colors.grey,
                                      style: BorderStyle.solid))),
                          validator: (String? valid) {
                            if (valid!.isEmpty) {
                              return "Please enter your mail";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          obscureText: ShopLoginCubit.get(context).isPassword,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          decoration: InputDecoration(
                              label: Text('Password'),
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  ShopLoginCubit.get(context).changeIcon();
                                },
                                icon: Icon(ShopLoginCubit.get(context).suffix),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 1.0,
                                      color: Colors.grey,
                                      style: BorderStyle.solid))),
                          validator: (String? valid) {
                            if (valid!.isEmpty) {
                              return "Please enter your password";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingStates,
                          builder: (context) => defaultButton(
                            isUppercase: true,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: 'login',
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('you don\'t have account?'),
                            const SizedBox(
                              width: 10.0,
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                child: const Text('Register'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
