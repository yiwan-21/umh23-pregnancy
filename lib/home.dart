import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Home'),
            centerTitle: true,
            floating: true,
            snap: true,
            // flexibleSpace: FlexibleSpaceBar(
            //   background: Image(
            //     image: NetworkImage(
            //       "https://img.freepik.com/free-vector/hand-drawn-fetus-illustration_23-2149205952.jpg?w=740&t=st=1683280539~exp=1683281139~hmac=5ab7d4dc7c8df9743624594421cfe81957330152991e379e3145dbbb3fb682a1",
            //     ),
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                
              ),
            ),
          ),
        ],
      ),
    );
  }
}
