import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared.dart';
import 'package:news_app/states.dart';
import '';
import 'cubit.dart';

class BusinessNews extends StatelessWidget {
  const BusinessNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
        builder: (context, state) {
        return ConditionalBuilder(
          condition: NewsCubit.get(context).businessNews.length > 0,
          builder: (context) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildNewsScreens(NewsCubit.get(context).businessNews[index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: NewsCubit.get(context).businessNews.length);
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
    },
       );
  }
}
