import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:movie_app/layout/movie_app/cubit/cubit.dart';
import 'package:movie_app/layout/movie_app/cubit/states.dart';
import 'package:movie_app/models/movie_app/movie_model.dart';
import 'package:movie_app/modules/movie_app/popular_movies/popular_movies_screen_details.dart';
import 'package:movie_app/shared/components/components.dart';

class SearchMoviesScreen extends StatelessWidget {

  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>(); //validator

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit,MoviesState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            centerTitle: true,
            title: Text(
              'Search',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                  children:
                  [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:
                        [
                          Expanded(
                            child: defaultTextFormField(
                              fieldController: searchController,
                              inputType: TextInputType.text,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'enter Movie Name ';
                                }
                              },
                              onChange: (String text){
                                if(searchController != "")
                                  MoviesCubit.get(context).getSearchData(text);
                              },
                              labelText: 'enter a movie name',
                              prefixIcon: Icons.search,
                              raduis: 30.0,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green[600],
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                            ),
                            height: 60.0,
                          ),
                        ],
                      ),
                    ),
                    if(state is MoviesGetSearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildMovieItem(MoviesCubit.get(context).searchMovies[index],context),
                      separatorBuilder:(context, index) => SizedBox(height: 8.0,),
                      itemCount: MoviesCubit.get(context).searchMovies.length,
                    ),
                  ]
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildMovieItem(MovieModel movieModel,context){
    String movieGenre = getMovieGenre(movieModel.genresId!, context);

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      child: InkWell(
        onTap: (){
          navigateTo(context,PopularMoviesScreenDetails(movieModel));
        },
        child: Row(
          children:
          [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: (movieModel.moviePoster ==null)?
                Image.asset('images/default movie poster.jpg',
                  width: (MediaQuery.of(context).size.width/3),
                  height: (MediaQuery.of(context).size.height/4 ),
                  fit: BoxFit.fill,
                ) :Image.network(
                  'https://image.tmdb.org/t/p/w500${movieModel.moviePoster.toString()}'
                  , width: (MediaQuery.of(context).size.width/3),
                  height: (MediaQuery.of(context).size.height/4 ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      movieModel.movieTitle.toString(),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.justify,
                      maxLines: 3,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      movieGenre,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                          '${movieModel.voteAverage}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.star_rate,
                          color: Colors.yellow,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getMovieGenre(List<int>list, context){
    if (list.length > 0) {
      String genre =
          MoviesCubit.get(context).moviesGenres[list[0]].toString() + '/';
      for (int i = 1; i < list.length - 1; i++) {
        genre += MoviesCubit.get(context).moviesGenres[list[i]].toString() + '/';
      }
      genre += MoviesCubit.get(context).moviesGenres[list[list.length - 1]].toString();
      return genre;
    }
    return 'not found';
  }

}
