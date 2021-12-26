import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:movie_app/layout/movie_app/cubit/cubit.dart';
import 'package:movie_app/layout/movie_app/cubit/states.dart';
import 'package:movie_app/models/movie_app/movie_model.dart';
import 'package:movie_app/shared/components/components.dart';

import 'now_playing_movies_screen_details.dart';

class NowPlayingMoviesScreen extends StatelessWidget {

  int selected_page = 1;

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<MoviesCubit,MoviesState>(
      listener: (context,state){},
      builder: (context,state){
        return Conditional.single(
            context: context,
            conditionBuilder: (context) => MoviesCubit.get(context).now_playingMovies.length > 0,
            widgetBuilder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children:
                  [
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height/15,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: MoviesCubit.get(context).totalPages,
                        separatorBuilder:(context , index ) => SizedBox(width: 40.0,),
                        itemBuilder: (context,index) => InkWell(
                          onTap: (){
                            selected_page = index+1 ;
                            MoviesCubit.get(context).getNowPlayingMovies(selected_page);
                          },
                          child: Text(
                            '${index+1}',
                            style: TextStyle(
                                color:  (selected_page==(index+1))? Colors.deepOrange : Colors.black,
                                fontSize: (selected_page==(index+1))? 23 : 20,
                                fontWeight:  (selected_page==(index+1))? FontWeight.bold : FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 4.0,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.deepOrange,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2, // grid row consist of 2 cells
                      mainAxisSpacing: 2.0, // space between items of column
                      crossAxisSpacing: 2.0, // space between items of row
                      childAspectRatio: 1/2.0, // width / height
                      children: List.generate(
                        MoviesCubit.get(context).now_playingMovies.length, (index) => buildGridMovie(MoviesCubit.get(context).now_playingMovies[index], context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fallbackBuilder: (context) =>Center(child: CircularProgressIndicator(),)
        );
      },
    );
  }

  Widget buildGridMovie(MovieModel movieModel,context) {
    String movieGenre = getMovieGenre(movieModel.genresId!, context);
    return InkWell(
      onTap: (){
        navigateTo(context,NowPlayingMoviesScreenDetails(movieModel));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children:
          [
            Container(
              // height: (size.height/2),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: (movieModel.moviePoster == null)?
              Image.asset('images/default movie poster.jpg',
                width: double.infinity,
                height: (MediaQuery.of(context).size.height / 3.2),
                fit: BoxFit.fill,
              ) :Image.network(
                'https://image.tmdb.org/t/p/w500${movieModel.moviePoster.toString()}'
                , width: double.infinity,
                height: (MediaQuery.of(context).size.height / 3.2),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              movieModel.movieTitle.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 5.0,
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
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [
                Icon(
                  Icons.star_rate,
                  color: Colors.yellow,
                  size: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  '${movieModel.voteAverage}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
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
