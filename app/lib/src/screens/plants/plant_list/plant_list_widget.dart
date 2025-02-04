import 'dart:math';

import 'package:flutter/material.dart';
import 'package:leafy_demo/src/state/global_state.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../state/plant_state.dart';
import '../plant_details_view.dart';

class PlantListItemView extends StatefulWidget {
  const PlantListItemView({
    super.key,
  });

  @override
  State<PlantListItemView> createState() => _PlantListItemViewState();
}

class _PlantListItemViewState extends State<PlantListItemView> {
  final Random _random = Random();

  Future<void> onPlantClick(String id) async {
    Provider.of<PlantModel>(context, listen: false).get(id);

    if (!mounted) {
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => const PlantMoreDetailsView()));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalModel>(builder: (_, globalModel, __) {
      return Consumer<PlantModel>(
        builder: (_, plantModel, __) {
          return Skeletonizer(
            enabled: globalModel.isLoading,
            child: ListView.builder(
                itemCount: plantModel.list.plants.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final itemColor = globalModel.colors[_random.nextInt(globalModel.colors.length)];
                  final darkItemColor = HSLColor.fromColor(itemColor).withLightness(0.35).toColor();

                  return GestureDetector(
                    onTap: () => onPlantClick(plantModel.list.plants[index].id),
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
                              Skeleton.replace(
                                child: Image(
                                  image: NetworkImage(plantModel.list.plants[index].imageURL),
                                  fit: BoxFit.cover,
                                  height: 130,
                                ),
                              ),
                              Container(
                                height: 100,
                                padding: const EdgeInsets.only(left: 20),
                                child:
                                    Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                }),
          );
        },
      );
    });
  }
}