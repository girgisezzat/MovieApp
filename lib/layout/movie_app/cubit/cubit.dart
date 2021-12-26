import 'package:bloc/bloc.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/layout/movie_app/cubit/states.dart';
import 'package:movie_app/models/movie_app/movie_list_model.dart';
import 'package:movie_app/models/movie_app/movie_model.dart';
import 'package:movie_app/modules/movie_app/approve_token/approve_token_screen.dart';
import 'package:movie_app/modules/movie_app/favourite_movies/favourite_movies_screen.dart';
import 'package:movie_app/modules/movie_app/mylists/mylists_screen.dart';
import 'package:movie_app/modules/movie_app/now_playing_movies/now_playing_movies_screen.dart';
import 'package:movie_app/modules/movie_app/popular_movies/popular_movies_screen.dart';
import 'package:movie_app/modules/movie_app/top_rated_movies/top_tated_movies.dart';
import 'package:movie_app/shared/components/basics.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:movie_app/shared/components/constants.dart';
import 'package:movie_app/shared/network/remote/dio_helper.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MoviesCubit extends Cubit<MoviesState>
{
  MoviesCubit() : super(MoviesInitialState());

  //to be more easily when use this cubit in many places
  static MoviesCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  List<BottomNavyBarItem> bottomNavBarItems = [

    BottomNavyBarItem(
        icon: Icon(Icons.local_movies_sharp),
        title: Text('Popular'),
        activeColor: Colors.deepOrange,
        inactiveColor: Colors.grey[600],
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.movie_filter_outlined),
      title: Text('Top_rated'),
      activeColor: Colors.deepOrange,
      inactiveColor: Colors.grey[600],
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.movie_creation_outlined),
      title: Text("Now_playing"),
      activeColor:Colors.deepOrange,
      inactiveColor:Colors.grey[600],
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.menu),
      title: Text("My_Lists"),
      activeColor:Colors.deepOrange,
      inactiveColor:Colors.grey[600],
    ),
  ];


  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.local_movies_sharp),
        title: ("Popular"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey[600],
        textStyle: TextStyle(
          fontSize: 15.0,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.movie_filter_outlined),
        title: ("Top_rated"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey[600],
        textStyle: TextStyle(
          fontSize: 15.0,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.movie_creation_outlined),
        title: ("Now_playing"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey[600],
        textStyle: TextStyle(
          fontSize: 15.0,
        ),
      ),
    ];
  }



  List<Widget> screens =[
    PopularMoviesScreen(),
    TopRatedMoviesScreen(),
    NowPlayingMoviesScreen(),
    MyListsScreen(),
  ];



  List<String> titles =[
    'Popular Movies',
    'Top_rated Movies',
    'Now_playing Movies',
    'My Lists',
  ];


  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    emit(MoviesBottomNavState());
  }



  bool favIconPressed = false;
  void changeFavIcon()
  {
    favIconPressed = !favIconPressed;
    emit(MoviesChangeFavIconState());
  }



  void radioBtnChanged()
  {
    emit(MovieRadioBtnSelectedChangedState());
  }


  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.add_box;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  })
  {
    isBottomSheetShown = isShow;
    fabIcon =icon;
    emit(MoviesChangeBottomNabSheetState());
  }



  bool isSearch = false;
  void searchByMovie()
  {
    isSearch = !isSearch;
    if(isSearch == false)
      emit(MoviesCheckSearchFalseState());
    else
      emit(MoviesCheckSearchTrueState());
  }


  int totalPages = 0;


  List<MovieModel> popularMovies = [];
  getPopularMovies(int page)
  {
    emit(MoviesGetPopularLoadingState());

    popularMovies = [];
    DioHelper.getData(
        url: 'movie/popular',
        query:
        {
          'api_key':apiKey,
          'page': page,
        }
    ).then((value){

      value.data['results'].forEach((element){
        MovieModel movieModel = MovieModel.fromJson(element);
        popularMovies.add(movieModel);
      });

      emit(MoviesGetPopularSuccessState());

      totalPages = value.data['total_pages'];


      for(int i = 0 ; i< popularMovies.length ; i++){
        print(popularMovies[i].movieTitle);
      }

    }).catchError((error){
      print('Error--> '+error.toString());
      print(error.toString());
      emit(MoviesGetTop_ratedErrorState(error.toString()));

    });
  }


  List<MovieModel> top_ratedMovies =[];
  void getTopRatedMovies(int page)
  {
    emit(MoviesGetTop_ratedLoadingState());

    top_ratedMovies = [];
    DioHelper.getData(
        url: 'movie/top_rated',
        query:
        {
          'api_key':apiKey,
          'page': page,
        }
    ).then((value)
    {
      value.data['results'].forEach((element){
        MovieModel movieModel = MovieModel.fromJson(element);
        top_ratedMovies.add(movieModel);
      });

      emit(MoviesGetTop_ratedSuccessState());

      totalPages = value.data['total_pages'];

      for(int i = 0 ; i< top_ratedMovies.length ; i++){
        print(top_ratedMovies[i].movieTitle);
      }

    }).catchError((error){
      print('Error--> '+error.toString());
      print(error.toString());
      emit(MoviesGetTop_ratedErrorState(error.toString()));
    });

  }


  List<MovieModel> now_playingMovies = [];
  void getNowPlayingMovies(int page)
  {
    emit(MoviesGetNow_playingLoadingState());

    now_playingMovies = [];
    DioHelper.getData(
        url: 'movie/now_playing',
        query:
        {
          'api_key':apiKey,
          'page': page,
        }
    ).then((value)
    {
      value.data['results'].forEach((element){
        MovieModel movieModel = MovieModel.fromJson(element);
        now_playingMovies.add(movieModel);
      });

      emit(MoviesGetNow_playingSuccessState());

      totalPages = value.data['total_pages'];

      for(int i = 0 ; i< now_playingMovies.length ; i++){
        print(now_playingMovies[i].movieTitle);
      }

    }).catchError((error){
      print('Error--> '+error.toString());
      print(error.toString());
      emit(MoviesGetNow_playingErrorState(error.toString()));
    });

  }



  Map<int, String> moviesGenres = {};
  void getMoviesGenres()
  {
    emit(MoviesGetGenresMoviesLoadingState());
    moviesGenres = {};
    DioHelper.getData(

        url: 'genre/movie/list',
        query:
        {
          'api_key':apiKey,
        }
    ).then((value){
      //print(value.data);
      value.data['genres'].forEach((element){
        moviesGenres.addAll({element['id']:element['name']});
      });
      emit(MoviesGetGenresMoviesSuccessState());
      print(moviesGenres);

    }).catchError((error){

      emit(MoviesGetGenresMoviesErrorState(error.toString()));
      print(error.toString());
      print('Error--> '+error.toString());
    });
  }



  List<MovieModel> searchMovies = [];
  void getSearchData(String value)
  {
    emit(MoviesGetSearchLoadingState());

    searchMovies = [];
    DioHelper.getData(

        url: 'search/movie',
        query:
        {
          'api_key':apiKey,
          'query':value,
        }
    ).then((value){

      value.data['results'].forEach((element){
        MovieModel movieModel = MovieModel.fromJson(element);
        searchMovies.add(movieModel);
      });
      emit(MoviesGetSearchSuccessState());

    }).catchError((error){

      emit(MoviesGetSearchErrorState(error.toString()));
      print(error.toString());
      print('Error--> '+error.toString());
    });
  }


  String? listId;
  List<MovieListModel> listModel = [];


  void createList({
    required String listName,
    required String listDescription,
  })
  {
    emit(MoviesCreateListLoadingState());

    DioHelper.postData(
      url: 'list',
      data: null,
      query: {
        'api_key':apiKey,
        'session_id':sessionId,
        'Content-Type':'application/json;charset=utf-8',
        'name':listName,
        'description':listDescription,
      },

    ).then((value){


      if(value.data['success'] && value.data['status_code']==1){

        listId = value.data['list_id'].toString();

        FirebaseFirestore.instance
            .collection('list')
            .doc(token)
            .collection('lists')
            .doc(listId)
            .set({'listId':listId, 'listName':listName}).then((value){
        }).catchError((error){
          emit(MoviesCreateListErrorState(error.toString()));
        });

      }

      print("ListId ---------->" + listId.toString());

      showToast(
        text: 'List created successfully',
        state: ToastStates.SUCCESS,
      );
      emit(MoviesCreateListSuccessState());

    }).catchError((error){
      print('Error--> '+error.toString());
      emit(MoviesCreateListErrorState(error.toString()));
      print(error.toString());
    });
  }



  void getListData()
  {
    emit(MoviesGetListLoadingState());
    listModel = [];

    FirebaseFirestore.instance
        .collection('list')
        .doc(token)
        .collection('lists')
        .snapshots()
        .listen((event) {
          listModel = [];
          event.docs.forEach((element) {
            MovieListModel movieListModel = MovieListModel.fromJson(element.data());
            listModel.add(movieListModel);
          });
          emit(MoviesGetListSuccessState());

          for(int i=0;i<listModel.length;i++){
            print('List name ------------> ' + listModel[i].listName!);
          }

        });
  }



  void addMovieToList({
    required String listId,
    required int movieId,

  })
  {

    emit(MoviesAddMovieToListLoadingState());

    DioHelper.postData(
      url: 'list/$listId/add_item',
      data: null,
      query: {
        'Content-Type':'application/json;charset=utf-8',
        'api_key':apiKey,
        'session_id':sessionId,
        'media_id': movieId,
      },
    ).then((value) {
      if(value.data['status_code']==12){
        showToast(
          text: 'Movie added successfully',
          state: ToastStates.SUCCESS,
        );
      }
      emit(MoviesAddMovieToListSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(MoviesAddMovieToListErrorState(error.toString()));
      print('Error--> '+error.toString());
    });
  }



  List<MovieModel> listMovie = [];
  void getListMovies({
    required String listId,
  })
  {
    emit(MoviesGetListMoviesLoadingState());
    listMovie = [];
    DioHelper.getData(
        url: 'list/$listId',
        query: {
          'list_id':listId,
          'api_key':apiKey,
        }
    ).then((value){
      value.data['items'].forEach((element){
        listMovie.add(MovieModel.fromJson(element));
      });
      emit(MoviesGetListMoviesSuccessState());

    }).catchError((error){
      print(error.toString());
      emit(MoviesGetListMoviesErrorState(error.toString()));
      print('Error--> '+error.toString());
    });
  }



  void rateMovie({
    required int movieId,
    required double rate,
  })
  {
    emit(MoviesRateMovieLoadingState());

    DioHelper.postData(
      url: 'movie/$movieId/rating',
      data: null,
      query: {
        "movie_id": movieId,
        'api_key':apiKey,
        'session_id':sessionId,
        'value': rate,
      },

    ).then((value){

      print(value.data);

      if(value.data['status_code']==1){
        showToast(
          text: 'your rating is done successfully',
          state: ToastStates.SUCCESS,
        );
      }

      if(value.data['status_code']==12){
        showToast(
          text: 'your rating is updated successfully',
          state: ToastStates.SUCCESS,
        );
      }


      emit(MoviesRateMovieSuccessState());

    }).catchError((error){

      print('Error--> '+error.toString());
      emit(MoviesRateMovieErrorState(error.toString()));
      print(error.toString());

    });
  }


  Future<bool> isMovieExist({
    required String listId,
    required int movieId,
  }) async {
    emit(MoviesCheckIfMovieExistInListLoadingState());

    try{
      var res = await DioHelper.getData(
          url: 'list/$listId/item_status',
          query: {
            'list_id':listId,
            'api_key':apiKey,
            'movie_id':movieId,
          }
      );
      emit(MoviesCheckIfMovieExistInListTrueState());
      if(res.data['item_present'] == false){
        return true;
      }
      return false;

    }catch(error){
      print(error.toString());
      emit(MoviesCheckIfMovieExistInListFalseState(error.toString()));
      print('Error--> '+error.toString());
      return false;
    }
  }



  void simpleNotificationMessage({
    required String msgText,
    Color msgColor = Colors.green,
    NotificationPosition notificationPosition = NotificationPosition.bottom,
  })
  {
    showSimpleNotification(
      Text(
        msgText,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
      ),
      position: notificationPosition,
      background: msgColor,
    );
  }



  void addMovieToFav({
    required String movieGenres,
    required MovieModel movieModel,
  })
  {
    emit(MoviesAddMovieToFavoriteLoadingState());

    FirebaseFirestore.instance
        .collection('favourites')
        .doc(token)
        .collection('fav_movies')
        .doc(movieModel.movieId.toString())
        .set(movieModel.toMap(movieGenres)).then((value){

      simpleNotificationMessage(msgText: 'added to favourites');

      emit(MoviesAddMovieToFavoriteSuccessState());

    }).catchError((error){
      print(error.toString());
      emit(MoviesAddMovieToFavoritesErrorState(error.toString()));
      print('Error----------> '+ error.toString());

    });
  }



  List<MovieModel> favMovies = [];
  void getMovieFromFav()
  {
    emit(MoviesGetMovieFromFavoriteLoadingState());
    favMovies = [];

    FirebaseFirestore.instance
        .collection('favourites')
        .doc(token)
        .collection('fav_movies')
        .snapshots()
        .listen((event) {

          favMovies = [];
          event.docs.forEach((element) {
            MovieModel movieModel = MovieModel.fromJson(element.data());
            favMovies.add(movieModel);
          });

          for(int i=0;i<favMovies.length;i++){
            print('Movie name ------------> ' + favMovies[i].movieTitle!);
          }

          emit(MoviesGetMovieFromFavoriteSuccessState());
    });
  }



  void clearList({
    required String listId,
  })
  {

    emit(MoviesClearListLoadingState());

    DioHelper.postData(
      url: 'list/$listId/clear',
      data: null,
      query: {
        "list_id": listId,
        'api_key':apiKey,
        'session_id':sessionId,
        'confirm': true,
      },

    ).then((value){

      print(value.data);

      if(value.data['status_code']==12){
        simpleNotificationMessage(
          msgText: 'List Cleared successfully',
        );
      }

      emit(MoviesClearListSuccessState());

    }).catchError((error){

      print('Error--> '+error.toString());
      emit(MoviesClearListErrorState(error.toString()));
      print(error.toString());

    });

  }



  void removeListFromFireStore({
    required String listId,
  })
  {
    emit(MoviesRemoveListLoadingState());

    FirebaseFirestore.instance
        .collection('list')
        .doc(token)
        .collection('lists')
        .doc(listId)
        .delete()
        .then((value) {
          simpleNotificationMessage(
            msgText: 'list removed',
          );
          emit(MoviesRemoveListSuccessState());
    }).catchError((error){
      print('Error -----------> '+ error.toString());
      emit(MoviesRemoveListErrorState(error.toString()));
      print(error.toString());
    });
  }



  void removeMovieFromList({
    required String listId,
    required String movieId,
  })
  {

    emit(MoviesRemoveMovieFromListLoadingState());

    DioHelper.postData(
      url: 'list/$listId/remove_item',
      data: null,
      query: {
        "list_id": listId,
        'api_key':apiKey,
        'session_id':sessionId,
        'Content-Type': 'application/json;charset=utf-8',
        'media_id': movieId,
      },

    ).then((value){

      print(value.data);

      if(value.data['status_code']==13){
        simpleNotificationMessage(
          msgText: 'Movie Removed successfully',
        );
      }

      emit(MoviesRemoveMovieFromListSuccessState());

    }).catchError((error){

      print('Error--> '+error.toString());
      emit(MoviesRemoveMovieFromListErrorState(error.toString()));
      print(error.toString());

    });
  }



  void reload()
  {
    emit(MovieReloadState());
  }


}