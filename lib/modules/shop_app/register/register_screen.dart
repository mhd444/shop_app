import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/modules/shop_app/register/cubit/cubit.dart';
import 'package:my_app/modules/shop_app/register/cubit/states.dart';

import '../../../layouts/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cash_helper.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state){
          if (state is ShopRegisterSuccessStates) {
            if (state.registerModel.status) {
              CashHelper.saveData(
                  key: 'token',
                  value: state.registerModel.data.token)
                  .then((value) {
                token = state.registerModel.data.token;
                navigateAndFinish(context, const ShopLayout());
              });
            } else {
              showToast(
                text: state.registerModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state){
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
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register now to brows our hot offers',
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
                          height: 10.0,
                        ),
                        TextFormField(
                          obscureText: ShopRegisterCubit.get(context).isPassword,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          onFieldSubmitted: (value) {
                            // if (formKey.currentState!.validate()) {
                            //   ShopLoginCubit.get(context).userLogin(
                            //       email: emailController.text,
                            //       password: passwordController.text);
                            // }
                          },
                          decoration: InputDecoration(
                              label: Text('Password'),
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  ShopRegisterCubit.get(context).changeIcon();
                                },
                                icon: Icon(ShopRegisterCubit.get(context).suffix),
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
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: nameController,
                          decoration: InputDecoration(
                              label: Text('Name'),
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 1.0,
                                      color: Colors.grey,
                                      style: BorderStyle.solid))),
                          validator: (String? valid) {
                            if (valid!.isEmpty) {
                              return "Please enter your name";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: phoneController,
                          decoration: InputDecoration(
                              label: Text('Phone number'),
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 1.0,
                                      color: Colors.grey,
                                      style: BorderStyle.solid))),
                          validator: (String? valid) {
                            if (valid!.isEmpty) {
                              return "Please enter your phone";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingStates,
                          builder: (context) => defaultButton(
                            isUppercase: true,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    name: nameController.text,
                                );
                              }
                            },
                            text: 'Register',
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
