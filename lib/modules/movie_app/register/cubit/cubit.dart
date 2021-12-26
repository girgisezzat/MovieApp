import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/movie_app/movie_user_model.dart';
import 'package:movie_app/modules/movie_app/register/cubit/states.dart';



class MovieRegisterCubit extends Cubit<MovieRegisterState> {

  MovieRegisterCubit() : super(MovieRegisterInitialState());

  //to be more easily when use this cubit in many places
  static MovieRegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  })
  {
    print('hello');
    emit(MovieRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      userCreate(
        uId: value.user!.uid,
        phone: phone,
        email: email,
        name: name,
      );
      print(value.user!.email);
      print(value.user!.uid);
    }).catchError((error) {
      print(error.toString());
      emit(MovieRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    MovieUserModel model = MovieUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap()).then((value) {
          emit(MovieCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(MovieCreateUserErrorState(error.toString()));
    });
  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(MovieRegisterChangePasswordVisibilityState());
  }
}