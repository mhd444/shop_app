import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layouts/shop_app/cubit/cubit.dart';
import 'package:my_app/layouts/shop_app/cubit/states.dart';
import 'package:my_app/shared/components/components.dart';

import '../../../shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state){},
        builder: (context, state){

          var formKey = GlobalKey<FormState>();
          var model = ShopCubit.get(context).userDataModel;
          nameController.text = model!.data.name;
          emailController.text = model.data.email;
          phoneController.text = model.data.phone;

          return ConditionalBuilder(
            condition: ShopCubit.get(context).userDataModel != null,
            builder:(context) => Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserDataStates)
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                    TextFormField(
                      keyboardType: TextInputType.name,
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
                          return "name must not be empty";
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
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
                          return "email must not be empty";
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: InputDecoration(
                          label: Text('Phone Number'),
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 1.0,
                                  color: Colors.grey,
                                  style: BorderStyle.solid))),
                      validator: (String? valid) {
                        if (valid!.isEmpty) {
                          return "Phone must not be empty";
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        function: (){
                          signOut(context);
                        },
                        text: 'Logout',
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        function: (){
                          if(formKey.currentState!.validate()){
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        text: 'Update',

                    )
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        }
      ),
    );
  }
}