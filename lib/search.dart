import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit.dart';
import 'package:news_app/shared.dart';
import 'package:news_app/states.dart';

class Search extends StatelessWidget {

var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<NewsCubit, NewsState>(
        listener: (context,state) => {},
       builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'No data entered';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    NewsCubit.get(context).getSearchData(value);
                  },
                ),
              ),
            ConditionalBuilder(
              condition: NewsCubit.get(context).searchNews.length > 0,
              builder: (context) {
                return Expanded(
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildNewsScreens(NewsCubit.get(context).searchNews[index], context,),
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: NewsCubit.get(context).searchNews.length),
                );
              },
              fallback: (context) => Container()
            )
            ],
          );
       }
      ),
    );
  }
}
