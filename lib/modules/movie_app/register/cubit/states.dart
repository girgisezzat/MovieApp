abstract class MovieRegisterState {}

class MovieRegisterInitialState extends MovieRegisterState {}


class MovieRegisterLoadingState extends MovieRegisterState {}
class MovieRegisterSuccessState extends MovieRegisterState
{
  late final String email;
  late final String password;
  MovieRegisterSuccessState(this.email,this.password);
}
class MovieRegisterErrorState extends MovieRegisterState
{
  final String error;
  MovieRegisterErrorState(this.error);
}


class MovieCreateUserSuccessState extends MovieRegisterState {}
class MovieCreateUserErrorState extends MovieRegisterState
{
  final String error;
  MovieCreateUserErrorState(this.error);
}


class MovieRegisterChangePasswordVisibilityState extends MovieRegisterState {}