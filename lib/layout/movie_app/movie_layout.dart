import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/movie_app/cubit/states.dart';
import 'package:movie_app/models/movie_app/movie_model.dart';
import 'package:movie_app/modules/movie_app/login/login_screen.dart';
import 'package:movie_app/modules/movie_app/popular_movies/popular_movies_screen.dart';
import 'package:movie_app/modules/movie_app/search_movies/search_movies_screen.dart';
import 'package:movie_app/shared/components/basics.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:movie_app/shared/network/local/cache_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'cubit/cubit.dart';

class MoviesLayout extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();//validator
  var formKey = GlobalKey<FormState>();//validator

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<MoviesCubit,MoviesState>(
      listener: (context,state){
        if(state is MoviesCreateListSuccessState)
        {
          Navigator.pop(context);
        }
      },
      builder: (context,state){
        var cubit = MoviesCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            actions:
            [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: (){
                  navigateTo(context,SearchMoviesScreen());
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.logout,
                ),
                onPressed: (){
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.WARNING,
                    animType: AnimType.BOTTOMSLIDE,
                    title: 'Logout',
                    desc: 'Are you sure that you want to Logout',
                    btnCancelOnPress: () {
                    },
                    btnOkOnPress: () {
                      logOut(context: context).then((value) {
                        CacheHelper.removeData(key: 'email');
                        CacheHelper.removeData(key: 'password');
                        CacheHelper.removeData(key: 'token');
                        CacheHelper.removeData(key: 'sessionId');
                        navigateAndFinish(context, MovieLoginScreen());
                      });
                    },
                  ).show();
                },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              scaffoldKey.currentState!.showBottomSheet((context) => Container(
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          [
                            SizedBox(
                              height: 30.0,
                            ),
                            defaultTextFormField(
                              fieldController: titleController,
                              inputType:  TextInputType.text,
                              validator:  (value){
                                if(value!.isEmpty){
                                  return 'List Can Not Be Empty ';
                                }
                              },
                              labelText: 'List Title',
                              prefixIcon:  Icons.title,
                              raduis: 30.0,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaultTextFormField(
                              fieldController: descriptionController,
                              inputType:  TextInputType.text,
                              validator:  (value){
                                if(value!.isEmpty){
                                  return 'Description Can Not Be Empty ';
                                }
                              },
                              labelText: 'description',
                              prefixIcon:  Icons.info,
                              raduis: 30.0,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if(formKey.currentState!.validate()){
                                  cubit.createList(
                                    listName: titleController.text,
                                    listDescription: descriptionController.text,
                                  );
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                [
                                  Icon(
                                    Icons.add,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Create List',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ).closed.then((value){
                cubit.changeBottomSheetState(
                  isShow: false,
                  icon: Icons.add_box,
                );
              });
              cubit.changeBottomSheetState(
                isShow: true,
                icon: Icons.edit,
              );
            },
            child: Icon(
              cubit.fabIcon,
            ),
          ),
          bottomNavigationBar: BottomNavyBar(
            //backgroundColor: defaultColor,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            iconSize: 30,
            selectedIndex: cubit.currentIndex,
            onItemSelected: (int index) {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomNavBarItems,
          ),
        );
      },
    );
  }
}
