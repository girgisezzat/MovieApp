import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/modules/movie_app/login/cubit/states.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:movie_app/shared/components/constants.dart';
import 'package:movie_app/shared/network/remote/dio_helper.dart';


class MovieLoginCubit extends Cubit<MovieLoginState>
{

  MovieLoginCubit() : super(MovieLoginInitialState());

  //to be more easily when use this cubit in many places
  static MovieLoginCubit get(context)=>BlocProvider.of(context);


  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(MovieLoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(MovieLoginSuccessState(email,password));
    }).catchError((error)
    {
      emit(MovieLoginErrorState(error.toString()));
      print(error.toString());
    });
  }



  void generateToken(){
    emit(MoviesGenerateTokenLoadingState());

    DioHelper.getData(
        url: 'authentication/token/new',
        query: {
          'api_key':apiKey,
        }
    ).then((value){

      print(value.data);
      token = value.data['request_token'];
      print('token = '+ token.toString());

      emit(MoviesGenerateTokenSuccessState());

    }).catchError((error){
      print('Error--> '+error.toString());
      emit(MoviesGenerateTokenErrorState(error.toString()));
      print(error.toString());

    });
  }



  void createSessionWithLogIn({
    required String username,
    required String password,
  }){
    emit(MoviesGenerateSessionLoadingState());

    DioHelper.postData(
      url: 'authentication/session/new',
      data: null,
      query: {
        'api_key':apiKey,
        'request_token':token,
        "username": username,
        "password": password,
      },

    ).then((value){

      // print(value.extra);
      if(value.data['success']){

        sessionId = value.data['session_id'];
        print('Session ID --------> '+sessionId!);
        token_approved = true;
        print('TOKEN_APPROVED ID --------> '+token_approved.toString());
        showToast(
          text: 'Session created successfully',
          state: ToastStates.SUCCESS,
        );
      }

      emit(MoviesGenerateSessionSuccessState());

    }).catchError((error){

      print('Error--> '+error.toString());
      emit(MoviesGenerateSessionErrorState(error.toString()));
      print(error.toString());
      token_approved = false;

    });
  }



  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(MovieChangePasswordVisibilityState());
  }

}