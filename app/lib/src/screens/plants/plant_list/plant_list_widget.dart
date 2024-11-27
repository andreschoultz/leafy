import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state/plant_state.dart';
import '../../../utils/constants/assets_constants.dart';
import '../plant_details_view.dart';

class PlantListItemView extends StatefulWidget {
  const PlantListItemView({
    super.key,
  });

  @override
  State<PlantListItemView> createState() => _PlantListItemViewState();
}

class _PlantListItemViewState extends State<PlantListItemView> {
  List<Color> colors = const [
    Color.fromRGBO(194, 214, 189, 1),
    Color.fromRGBO(201, 227, 227, 1),
    Color.fromRGBO(242, 218, 198, 1),
    Color.fromRGBO(210, 216, 227, 1),
    Color.fromRGBO(240, 226, 226, 1),
  ];

  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantModel>(builder: (_, plantModel, __) {
      return ListView.builder(
          itemCount: plantModel.list.plants.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final itemColor = colors[_random.nextInt(colors.length)];
            final darkItemColor = HSLColor.fromColor(itemColor).withLightness(0.35).toColor();

            return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PlantMoreDetailsView())),
              child: Container(
                height: 140,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: itemColor,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage(Asset.flowers['peaceLily']!),
                          fit: BoxFit.cover,
                          height: 130,
                        ),
                        Container(
                          height: 100,
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(
                              plantModel.list.plants[index].name,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.water_drop_outlined,
                                  color: darkItemColor,
                                ),
                                const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                                Text(
                                  '${plantModel.list.plants[index].weeklyWater} ml',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18,
                                    color: darkItemColor,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }
}
