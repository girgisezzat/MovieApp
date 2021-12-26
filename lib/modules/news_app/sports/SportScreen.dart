import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/news_app/cubit/cubit.dart';
import 'package:movie_app/layout/news_app/cubit/states.dart';
import 'package:movie_app/shared/components/components.dart';



class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsState>(
        listener:(context,state){} ,
        builder: (context,state){

          List<dynamic> list = NewsCubit.get(context).sports;
          return articleBuilder( list: list, context: context);
        }
    );
  }
}
