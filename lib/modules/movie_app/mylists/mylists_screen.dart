import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:movie_app/layout/movie_app/cubit/cubit.dart';
import 'package:movie_app/layout/movie_app/cubit/states.dart';
import 'package:movie_app/models/movie_app/movie_list_model.dart';
import 'package:movie_app/models/movie_app/movie_model.dart';
import 'package:movie_app/modules/movie_app/mylists_details/mylists_details_screen.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class MyListsScreen extends StatelessWidget {

  MyListsScreen({Key? key}) : super(key: key);

  int start = 3;

  @override
  Widget build(BuildContext context) {
    var cubit = MoviesCubit.get(context);
    start = 3;
    startTimer(context);
    return BlocConsumer<MoviesCubit,MoviesState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              bottom: 10,
              left: 10,
              right: 10.0,
            ),
            child: Conditional.single(
              context: context,
              conditionBuilder: (context)=> cubit.listModel.length!=0,
              widgetBuilder: (context)=> ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildListItem(cubit.listModel[index],context),
                separatorBuilder: (context, index) =>myDivider(),
                itemCount: cubit.listModel.length,
              ),
              fallbackBuilder: (context) {
                if(cubit.listModel.length ==0 && start==0)
                  return Center(
                    child:Text(
                      'no movies found',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    ),
                  );
                else{
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget buildListItem(MovieListModel movieListModel,context) => Column(
    children:
    [
      SizedBox(
        height: 15,
      ),
      Row(
        children:
        [
          Text(
            movieListModel.listName!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 18,
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: (){
              StylishDialog(
                context: context,
                alertType: StylishDialogType.WARNING,
                titleText: 'Clear List',
                contentText: 'Are you sure that you want to Clear ${movieListModel.listName} list',
                confirmButton: MaterialButton(
                  color: Colors.deepOrange,
                  onPressed: () {
                    MoviesCubit.get(context).clearList(listId: movieListModel.listId!);
                    Navigator.of(context).pop();
                  },
                  child: (
                      Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                  ),
                ),
                cancelButton: MaterialButton(
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: (
                      Text(
                        'cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                  ),
                ),
              ).show();
            },
            icon: Icon(
              Icons.clear,
              color: Colors.green,
              size: 26,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          IconButton(
            onPressed: (){
              StylishDialog(
                context: context,
                alertType: StylishDialogType.WARNING,
                titleText: 'Remove List',
                contentText: 'Are you sure that you want to Remove ${movieListModel.listName} list',
                confirmButton: MaterialButton(
                  color: Colors.deepOrange,
                  onPressed: () {
                    MoviesCubit.get(context).removeListFromFireStore(listId: movieListModel.listId!);
                    Navigator.of(context).pop();
                  },
                  child: (
                      Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                  ),
                ),
                cancelButton: MaterialButton(
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: (
                      Text(
                        'cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                  ),
                ),
              ).show();
            },
            icon: Icon(
              Icons.delete,
              color: Colors.deepOrange,
              size: 26,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          IconButton(
            onPressed: (){
              MoviesCubit.get(context).getListMovies(listId: movieListModel.listId!);
              navigateTo(context, MyListsDetailsScreen(movieListModel: movieListModel));
            },
            icon: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey,
              size: 26,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 15,
      ),
    ],
  );

  void startTimer(context) {
    const Duration oneSec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (start == 0) {
          timer.cancel();
          MoviesCubit.get(context).reload();
        } else {
          start--;
        }
      },
    );
  }

}