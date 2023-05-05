import 'package:flutter/material.dart';

class Necessities extends StatelessWidget {
  Necessities({super.key});

  final Map<String, List> necessities = {
    "Mother's clothing": [
      "Nursing bras",
      "Nursing pads",
      "Nursing tops",
      "Maternity underwear",
      "Maternity pants"
    ],
    "Baby's clothing": ["Onesies", "Sleepers", "Socks", "Hats", "Mittens"],
    "Baby care": [
      "Wash cloths",
      "Thermometer",
      "Baby shampoo",
      "Baby brush",
      "Nail clippers"
    ],
    "Feeding supplies": [
      "Bottles",
      "Formula",
      "Breast pads",
      "Bibs",
      "Burp cloths"
    ],
    "Diapers and wipes": [
      "Diapers",
      "Wipes",
      "Diaper rash cream",
      "Baby powder",
      "Changing pad"
    ],
    "Nursery items": [
      "Crib",
      "Bassinets",
      "Changing table",
      "Rocking chair",
      "Baby monitor"
    ],
    "Safety items": [
      "Car seat",
      "Stroller",
      "Baby gate",
      "Outlet covers",
      "Babyproofing kit"
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('Necessities'),
          centerTitle: true,
          floating: true,
          snap: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: const Text("Shopping List",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              title: NecessitiesCard(
                title: necessities.keys.elementAt(index),
                items: necessities.values.elementAt(index),
              ),
            ),
            childCount: necessities.length,
          ),
        ),
      ],
    ));
  }
}

class NecessitiesCard extends StatefulWidget {
  final String title;
  final List items;

  const NecessitiesCard({required this.title, required this.items, super.key});

  @override
  State<NecessitiesCard> createState() => _NecessitiesCardState();
}

class _NecessitiesCardState extends State<NecessitiesCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _toggleExpanded,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _isExpanded ? 250 : 75,
          curve: Curves.fastOutSlowIn,
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            color: Colors.pink[50],
            child: Column(
              children: [
                ListTile(
                  title: Text(widget.title),
                  trailing: _isExpanded
                      ? const Icon(Icons.expand_less)
                      : const Icon(Icons.expand_more),
                ),
                if (_isExpanded)
                  const Expanded(
                    flex: 0,
                    child: Divider(
                      color: Colors.black,
                      height: 0,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                if (_isExpanded)
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(widget.items[index]),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
