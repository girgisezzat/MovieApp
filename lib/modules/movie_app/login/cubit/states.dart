abstract class MovieLoginState {}

class MovieLoginInitialState extends MovieLoginState{}

//Login With Email$Password
class MovieLoginLoadingState extends MovieLoginState{}
class MovieLoginSuccessState extends MovieLoginState
{
  late final String email;
  late final String password;
  MovieLoginSuccessState(this.email,this.password);
}
class MovieLoginErrorState extends MovieLoginState
{
  late final String error;

  MovieLoginErrorState(this.error);
}


//Login With Google
class MovieLoginWithGoogleLoadingState extends MovieLoginState{}
class MovieLoginWithGoogleSuccessState extends MovieLoginState {}
class MovieLoginWithGoogleErrorState extends MovieLoginState
{
  late final String error;

  MovieLoginWithGoogleErrorState(this.error);
}

//Get Token
class MoviesGenerateTokenLoadingState extends MovieLoginState {}
class MoviesGenerateTokenSuccessState extends MovieLoginState {}
class MoviesGenerateTokenErrorState extends MovieLoginState
{
  late final String error;

  MoviesGenerateTokenErrorState(this.error);
}


//Get SessionId
class MoviesGenerateSessionLoadingState extends MovieLoginState {}
class MoviesGenerateSessionSuccessState extends MovieLoginState {}
class MoviesGenerateSessionErrorState extends MovieLoginState
{
  late final String error;

  MoviesGenerateSessionErrorState(this.error);
}



class MovieChangePasswordVisibilityState extends MovieLoginState{}