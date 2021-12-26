abstract class MoviesState {}

class MoviesInitialState extends MoviesState {}
class MoviesBottomNavState extends MoviesState {}



//Get Popular Movie
class MoviesGetPopularLoadingState extends MoviesState {}
class MoviesGetPopularSuccessState extends MoviesState {}
class MoviesGetPopularErrorState extends MoviesState
{
  late final String error;

  MoviesGetPopularErrorState(this.error);
}


//Get Top_rated Movies
class MoviesGetTop_ratedLoadingState extends MoviesState {}
class MoviesGetTop_ratedSuccessState extends MoviesState {}
class MoviesGetTop_ratedErrorState extends MoviesState
{
  late final String error;

  MoviesGetTop_ratedErrorState(this.error);
}


//Get Now_playing Movies
class MoviesGetNow_playingLoadingState extends MoviesState {}
class MoviesGetNow_playingSuccessState extends MoviesState {}
class MoviesGetNow_playingErrorState extends MoviesState
{
  late final String error;

  MoviesGetNow_playingErrorState(this.error);
}


//Get Search Movies
class MoviesGetSearchLoadingState extends MoviesState {}
class MoviesGetSearchSuccessState extends MoviesState {}
class MoviesGetSearchErrorState extends MoviesState
{
  late final String error;
  MoviesGetSearchErrorState(this.error);
}


//Get Genres Movies
class MoviesGetGenresMoviesLoadingState extends MoviesState {}
class MoviesGetGenresMoviesSuccessState extends MoviesState {}
class MoviesGetGenresMoviesErrorState extends MoviesState
{
  late final String error;

  MoviesGetGenresMoviesErrorState(this.error);
}


//Create List
class MoviesCreateListLoadingState extends MoviesState {}
class MoviesCreateListSuccessState extends MoviesState {}
class MoviesCreateListErrorState extends MoviesState
{
  late final String error;

  MoviesCreateListErrorState(this.error);
}


//Get List
class MoviesGetListLoadingState extends MoviesState {}
class MoviesGetListSuccessState extends MoviesState {}
class MoviesGetListErrorState extends MoviesState
{
  late final String error;

  MoviesGetListErrorState(this.error);
}


//Clear List
class MoviesClearListLoadingState extends MoviesState {}
class MoviesClearListSuccessState extends MoviesState {}
class MoviesClearListErrorState extends MoviesState
{
  late final String error;

  MoviesClearListErrorState(this.error);
}


//Remove List
class MoviesRemoveListLoadingState extends MoviesState {}
class MoviesRemoveListSuccessState extends MoviesState {}
class MoviesRemoveListErrorState extends MoviesState
{
  late final String error;

  MoviesRemoveListErrorState(this.error);
}


//Remove Movie From List
class MoviesRemoveMovieFromListLoadingState extends MoviesState {}
class MoviesRemoveMovieFromListSuccessState extends MoviesState {}
class MoviesRemoveMovieFromListErrorState extends MoviesState
{
  late final String error;

  MoviesRemoveMovieFromListErrorState(this.error);
}


//Add Movie To List
class MoviesAddMovieToListLoadingState extends MoviesState {}
class MoviesAddMovieToListSuccessState extends MoviesState {}
class MoviesAddMovieToListErrorState extends MoviesState
{
  late final String error;

  MoviesAddMovieToListErrorState(this.error);
}


//Add Movie To Favourite
class MoviesAddMovieToFavoriteLoadingState extends MoviesState {}
class MoviesAddMovieToFavoriteSuccessState extends MoviesState {}
class MoviesAddMovieToFavoritesErrorState extends MoviesState
{
  late final String error;
  MoviesAddMovieToFavoritesErrorState(this.error);
}



//Get Movie From Favourite
class MoviesGetMovieFromFavoriteLoadingState extends MoviesState {}
class MoviesGetMovieFromFavoriteSuccessState extends MoviesState {}
class MoviesGetMovieFromFavoriteErrorState extends MoviesState
{
  late final String error;

  MoviesGetMovieFromFavoriteErrorState(this.error);
}


//Get List Movies
class MoviesGetListMoviesLoadingState extends MoviesState {}
class MoviesGetListMoviesSuccessState extends MoviesState {}
class MoviesGetListMoviesErrorState extends MoviesState
{
  late final String error;
  MoviesGetListMoviesErrorState(this.error);
}


//Rate Movie
class MoviesRateMovieLoadingState extends MoviesState {}
class MoviesRateMovieSuccessState extends MoviesState {}
class MoviesRateMovieErrorState extends MoviesState
{
  late final String error;

  MoviesRateMovieErrorState(this.error);
}


//Change FavIcon
class MoviesChangeFavIconState extends MoviesState {}


//Check Search
class MoviesCheckSearchTrueState extends MoviesState {}
class MoviesCheckSearchFalseState extends MoviesState {}


//Check Movie Exit In List or Not
class MoviesCheckIfMovieExistInListLoadingState extends MoviesState {}
class MoviesCheckIfMovieExistInListTrueState extends MoviesState {}
class MoviesCheckIfMovieExistInListFalseState extends MoviesState
{
  late final String error;
  MoviesCheckIfMovieExistInListFalseState(this.error);
}


class MoviesChangeBottomNabSheetState extends MoviesState {}


class MovieRadioBtnSelectedChangedState extends MoviesState {}

class MovieReloadState extends MoviesState {}
