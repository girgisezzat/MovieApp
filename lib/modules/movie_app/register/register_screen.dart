import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:movie_app/modules/basics_app/login/LoginScreen.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:movie_app/shared/components/constants.dart';
import 'package:movie_app/shared/components/constants.dart';
import 'package:movie_app/shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class MovieRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MovieRegisterCubit(),
      child: BlocConsumer<MovieRegisterCubit, MovieRegisterState>(
        listener: (context, state)
        {
          if (state is MovieRegisterSuccessState) {
            CacheHelper.saveData(
              key: 'email',
              value: state.email.toString(),
            );
            CacheHelper.saveData(
              key: 'password',
              value: state.password.toString(),
            );
            email = state.email;
            password = state.password;

            navigateAndFinish(context, LoginScreen());
          }
        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              centerTitle: true,
              title: Text(
                'Register',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
            ),
            body: Center(
              child:Stack(
                children:
                [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              'images/movie_picture1.jpg',
                            ),
                          ),
                        ),
                        width: double.infinity,
                        height: 250,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Form(
                            key: formKey,
                            child: Padding(
                              padding: EdgeInsets.all(
                                  8.0
                              ),
                              child:Column(
                                children:
                                [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Register now to watch Your Favourite movies',
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                      //fontSize: 15.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  defaultTextFormField(
                                    fieldController: nameController,
                                    inputType: TextInputType.name,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'please enter your name';
                                      }
                                    },
                                    labelText: 'User Name',
                                    raduis: 20.0,
                                    prefixIcon: Icons.person,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultTextFormField(
                                    fieldController: emailController,
                                    inputType: TextInputType.emailAddress,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'please enter your email address';
                                      }
                                    },
                                    labelText: 'Email Address',
                                    raduis: 20.0,
                                    prefixIcon: Icons.email_outlined,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultTextFormField(
                                    fieldController: phoneController,
                                    inputType: TextInputType.phone,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'please enter your phone number';
                                      }
                                    },
                                    labelText: 'Phone',
                                    raduis: 20.0,
                                    prefixIcon: Icons.phone,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultTextFormField(
                                    fieldController: passwordController,
                                    inputType: TextInputType.visiblePassword,
                                    obscureText: MovieRegisterCubit.get(context).isPassword,
                                    suffixIcon: MovieRegisterCubit.get(context).suffix,
                                    suffixClicked: (){
                                      MovieRegisterCubit.get(context).changePasswordVisibility();
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'please enter your password';
                                      }
                                    },
                                    labelText: 'Password',
                                    raduis: 20.0,
                                    prefixIcon: Icons.lock_outline,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultTextFormField(
                                    fieldController: confirmPasswordController,
                                    inputType: TextInputType.visiblePassword,
                                    obscureText: MovieRegisterCubit.get(context).isPassword,
                                    suffixIcon: MovieRegisterCubit.get(context).suffix,
                                    suffixClicked: (){
                                      MovieRegisterCubit.get(context).changePasswordVisibility();
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'please enter your password';
                                      }
                                      else if(value != passwordController.text)
                                        return 'Password Don\'t Match';
                                    },
                                    labelText: 'Confirm Password',
                                    raduis: 20.0,
                                    prefixIcon: Icons.lock_outline,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Conditional.single(
                                    context: context,
                                    conditionBuilder: (context)=> state is! MovieRegisterLoadingState,
                                    widgetBuilder: (context)=> defaultButton(
                                      function: () {
                                        if (formKey.currentState!.validate())
                                        {
                                          MovieRegisterCubit.get(context).userRegister(
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            phone: phoneController.text,
                                          );
                                        }
                                      },
                                      text: 'Register',
                                      raduis: 20.0,
                                      isUpperCase: true,
                                      btnColor: Colors.deepOrange,
                                    ),
                                    fallbackBuilder: (context)=>
                                        Center(child: CircularProgressIndicator()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
