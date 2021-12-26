import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:movie_app/layout/movie_app/cubit/cubit.dart';
import 'package:movie_app/layout/movie_app/cubit/states.dart';
import 'package:movie_app/models/movie_app/movie_list_model.dart';
import 'package:movie_app/models/movie_app/movie_model.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:overlay_support/overlay_support.dart';

class NowPlayingMoviesScreenDetails extends StatelessWidget {

  MovieModel movieModel;
  NowPlayingMoviesScreenDetails(this.movieModel);

  var formKey = GlobalKey<FormState>();//validator
  var scaffoldKey = GlobalKey<ScaffoldState>();//validator
  dynamic lstName;
  dynamic lstId;
  double rate = 2;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var rateController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit,MoviesState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            centerTitle: true,
            title: Text(
              movieModel.movieTitle.toString() +' ' + 'Details',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children:
                  [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5.0,
                      margin: EdgeInsets.all(
                        2.0,
                      ),
                      child:(movieModel.moviePoster == null)?
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
                    InkWell(
                      onTap: (){
                        MoviesCubit.get(context).changeFavIcon();
                      },
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.green.shade300,
                        child: (MoviesCubit.get(context).favIconPressed)?
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ):Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
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
                          padding: EdgeInsets.all(8.0),
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
                                movieModel.movieOverview.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600,
                                ),
                                textAlign: TextAlign.justify,
                                maxLines: 2,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${movieModel.movieReleaseDate.toString()} (Released)',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                              Center(
                                child: Container(
                                  height: 40,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  child: ElevatedButton(
                                    onPressed: (){},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green.shade300,
                                    ),
                                    child: Text(
                                      'Reviews',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    color: Colors.grey.shade300,
                    height: 2,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children:
                    [
                      Expanded(
                        child: Column(
                          children:
                          [
                            IconButton(
                              icon: Icon(
                                Icons.add,
                              ),
                              onPressed: (){
                                displayListDialog(context);
                              },
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'create list',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children:
                          [
                            IconButton(
                              icon: Icon(
                                Icons.star_border_outlined,
                              ),
                              onPressed: (){
                                displayRateDialog(context);
                              },
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'rate',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    color: Colors.grey.shade300,
                    height: 2,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Colors.red.shade700,
                                ),
                                CircleAvatar(
                                  radius: 23,
                                  backgroundColor: Colors.white,
                                ),
                                CircleAvatar(
                                  radius: 21,
                                  backgroundColor: Colors.red.shade700,
                                  child: Text(
                                    movieModel.voteAverage.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              '${movieModel.voteCount.toString()} Votes',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children:
                          [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.red.shade700,
                              child: Icon(Icons.theater_comedy,color: Colors.white,size: 30,),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Actions',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [

                                CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Colors.red.shade700,
                                ),
                                CircleAvatar(
                                  radius: 23,
                                  backgroundColor: Colors.white,
                                ),
                                CircleAvatar(
                                  radius: 21,
                                  backgroundColor: Colors.red.shade700,
                                  child: Text(movieModel.moviePopularity!.round().toString(),
                                    style: TextStyle(color: Colors.white,
                                        fontSize: 15
                                    ),),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Popularity',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [

                                CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Colors.red.shade700,
                                ),
                                CircleAvatar(
                                  radius: 23,
                                  backgroundColor: Colors.white,
                                ),
                                CircleAvatar(
                                  radius: 21,
                                  backgroundColor: Colors.red.shade700,
                                  child: Text(movieModel.movieOriginalLang.toString(),
                                    style: TextStyle(color: Colors.white,
                                        fontSize: 15

                                    ),),
                                )
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Text('Language',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600
                              ),
                            ),


                          ],
                        ),
                      )
                    ],),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    color: Colors.grey.shade300,
                    height: 2,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    child: Center(
                      child: Text(
                        movieModel.movieOverview.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildListItem(MovieListModel listModel,context) =>InkWell(
    onTap: (){},
    child: Row(
      children:
      [
        // RadioGroup<String>.builder(
        //   groupValue: '_verticalGroupValue',
        //   activeColor: Colors.deepOrange,
        //   onChanged: (value) {},
        //   items:
        //   [
        //     listModel.listName!,
        //   ],
        //   itemBuilder: (item) => RadioButtonBuilder(
        //     item,
        //   ),
        // ),

        Transform.scale(
          scale: 1.4,
          child: Radio(
              value: listModel.listName!,
              groupValue: lstName,
              onChanged: (value){
                print(value);
                lstName = value;
                lstId = listModel.listId;
                print("listId-----------------"+lstId);
                Navigator.pop(context);
                displayListDialog(context);
              }
          ),
        ),
        Text(
          listModel.listName!,
        )
      ],
    ),
  );

  void displayRateDialog(context) {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) => AlertDialog(
              title: Center(
                child: Text(
                  'Rate Movie',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22),
                ),
              ),
              actions: [
                Center(
                  child: RatingBar.builder(
                    initialRating: rate,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    maxRating: 5,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      rate = rating;
                      rateController.text = rate.toString();
                      print('tate-->' + rating.toString());
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: formKey,
                  child: defaultTextFormField(
                      fieldController: rateController,
                      inputType: TextInputType.number,
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return "rate can't be empty";
                        } else if (double.parse(val.toString()) < 0.5 ||
                            double.parse(val.toString()) > 5) {
                          return "rate must be between 0.5 and 5 ";
                        }
                      },
                      labelText: 'Enter your rate',
                      raduis: 8,
                      prefixIcon: Icons.star_rate,
                      onChange: (String? value) {
                        if (value.toString() != '') {
                          rate = double.parse(value.toString());
                        } else {
                          rate = 0;
                          print('null');
                        }
                        setState(() {});
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: defaultButton(
                        function: (){
                          if (formKey.currentState!.validate()) {
                            MoviesCubit.get(context).rateMovie(
                              movieId: movieModel.movieId!,
                              rate: rate,
                            );
                            Navigator.pop(context);
                          }
                        },
                        btnColor: Colors.deepOrange,
                        text: 'submit',
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: defaultButton(
                        function: (){
                          Navigator.pop(context);
                        },
                        btnColor: Colors.grey,
                        text: 'cancel',
                      ),
                    ),
                  ],
                ),
              ],
            )
        )
    );
  }

  void displayListDialog(context) {

    //Dialogs.materialDialog()
    Dialogs.bottomMaterialDialog(
        msg: 'Are you sure? you want to add \n ${movieModel.movieTitle} to list',
        title: 'Add to List',
        isScrollControlled: true,
        context: context,
        actions: [
          Column(
            children:
            [
              Container(
                height: 100,
                child: ListView.separated(
                  // shrinkWrap: true, //make list take part of screen
                  itemBuilder:(context, index)=>buildListItem(MoviesCubit.get(context).listModel[index],context),
                  separatorBuilder: (context, index)=>const SizedBox(height: 5,),
                  itemCount: MoviesCubit.get(context).listModel.length,
                ),
              ),
              IconsOutlineButton(
                onPressed: () {
                  Navigator.pop(scaffoldKey.currentContext!);
                },
                text: 'Cancel',
                iconData: Icons.cancel_outlined,
                textStyle: TextStyle(color: Colors.grey),
                iconColor: Colors.grey,
              ),
              IconsButton(
                onPressed: () async {
                  if(lstName==null){
                    showSimpleNotification(
                      Text(
                        "choose list first",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      position: NotificationPosition.bottom,
                      background: Colors.green,
                    );
                  }
                  else{
                    bool exist = await MoviesCubit.get(scaffoldKey.currentContext!).isMovieExist(
                      listId: lstId,
                      movieId: movieModel.movieId!,
                    );
                    if(exist){
                      MoviesCubit.get(scaffoldKey.currentContext!).addMovieToList(
                        listId: lstId,
                        movieId: movieModel.movieId!,
                      );
                    }else{
                      MoviesCubit.get(scaffoldKey.currentContext!).simpleNotificationMessage(
                        msgText: 'Movie Already exist in list',
                      );
                      Navigator.pop(scaffoldKey.currentContext!);
                    }

                  }
                },
                text: 'Add to list',
                iconData: Icons.save_alt_rounded,
                color: Colors.deepOrange,
                textStyle: TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ],
          ),
        ]);
  }

}
