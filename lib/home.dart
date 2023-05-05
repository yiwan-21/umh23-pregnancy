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
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10),
              child: const Text(
                "Welcome to Baby's First App!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/timeline');
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    const Image(
                      height: 100,
                      width: 400,
                      image: NetworkImage(
                        "https://img.freepik.com/free-vector/hand-drawn-fetus-illustration_23-2149205952.jpg?w=740&t=st=1683280539~exp=1683281139~hmac=5ab7d4dc7c8df9743624594421cfe81957330152991e379e3145dbbb3fb682a1",
                      ),
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Timeline",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
