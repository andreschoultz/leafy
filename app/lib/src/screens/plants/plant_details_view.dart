import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:leafy_demo/src/services/api/models/responses/plant_responses.dart';
import 'package:leafy_demo/src/state/global_state.dart';
import 'package:leafy_demo/src/state/plant_state.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlantMoreDetailsView extends StatefulWidget {
  const PlantMoreDetailsView({
    super.key,
  });

  static const routeName = '/plant/details';

  @override
  State<PlantMoreDetailsView> createState() => _PlantMoreDetailsViewState();
}

class _PlantMoreDetailsViewState extends State<PlantMoreDetailsView> {

  static const List<String> chipNames = ['Indoor', 'Garden', 'Office', 'Pet Friendly', 'Air Purifier'];

  List<InfoPillItemData> getInfoPillItems(PlantResponse plant) {
    return [
      InfoPillItemData('Humidity', '${plant.idealHumidityPerc}%', Icons.water_drop),
      InfoPillItemData('Height', '${plant.avgHeight}m', Icons.height),
      InfoPillItemData('Diameter', '${plant.avgDiameter}m', Icons.vertical_align_center),
      InfoPillItemData('Sunlight', '${plant.idealSunlightK}k', Icons.sunny),
    ];
  }

  Future<void> onAddToMyPlants() async {
    await Provider.of<PlantModel>(context, listen: false).add();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalModel>(builder: (_, globalModel, __) {
      return Consumer<PlantModel>(builder: (_, plantModel, __) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(241, 245, 249, 1),
            surfaceTintColor: const Color.fromRGBO(241, 245, 249, 1),
          ),
          floatingActionButton: globalModel.isLoading ? null : BottomButton(onPressed: () => ()),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 36, right: 36, bottom: 100),
            child: Skeletonizer(
              enabled: globalModel.isLoading,
              switchAnimationConfig: const SwitchAnimationConfig(
                duration: Duration(milliseconds: 500),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CoreImageContainer(imageURL: plantModel.plant.imageURL, infoPillItems: getInfoPillItems(plantModel.plant)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Text(plantModel.plant.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Wrap(
                    spacing: 6,
                    runSpacing: 12,
                    children: [
                      ...plantModel.plant.tags.map((item) => DescriptiveChipItem(label: item.name)),
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Text(
                          plantModel.plant.description,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}

class LoadingScreenOverlay extends StatelessWidget {
  const LoadingScreenOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center, height: MediaQuery.of(context).size.center(Offset.zero).dy, child: const CircularProgressIndicator());
  }
}

class DescriptiveChipItem extends StatelessWidget {
  const DescriptiveChipItem({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chip(
        label: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18))),
        side: const BorderSide(color: Color.fromRGBO(222, 222, 222, 1), width: 0.5),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(left: 36, right: 36),
      child: Column(
        children: [
          SizedBox(
            height: 60,
            width: double.infinity,
            child: FilledButton(
              onPressed: onPressed,
              style: ButtonStyle(padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(14))),
              child: const Text('Add To My Plant', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: FilledButton(
              onPressed: onPressed,
              style: ButtonStyle(padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(14))),
              child: const Text('Remove From My Plant', style: TextStyle(fontSize: 24)),
            ),
          ),
        ],
      ),
    );
  }
}

class CoreImageContainer extends StatelessWidget {
  const CoreImageContainer({
    super.key,
    required this.imageURL,
    required this.infoPillItems,
  });

  final String imageURL;
  final List<InfoPillItemData> infoPillItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      transform: Matrix4.translationValues(-36, 0, 0),
      height: 380,
      width: 1000,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(199, 193, 193, 0.3),
            spreadRadius: 0.7,
            blurRadius: 12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Image container
          Positioned(
            left: -40,
            top: -30,
            child: Skeleton.replace(
              child: Image(
                image: NetworkImage(imageURL),
                width: 320,
              ),
            ),
          ),
          // Button overlay container
          Positioned(
            right: -50, // Align to the middle-right
            top: 50, // Adjust this value to position vertically
            child: Container(
              child: Wrap(
                direction: Axis.vertical,
                spacing: 14,
                children: [...infoPillItems.map((item) => InfoPillItem(item: item))],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoPillItemData {
  const InfoPillItemData(this.label, this.descriptiveValue, this.icon);

  final String label;
  final String descriptiveValue;
  final IconData icon;
}

class InfoPillItem extends StatelessWidget {
  const InfoPillItem({super.key, required this.item});

  final InfoPillItemData item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      child: FilledButton.tonalIcon(
        onPressed: () => (),
        icon: Icon(item.icon),
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(5)),
          iconSize: WidgetStateProperty.all(30),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          backgroundColor: WidgetStateProperty.all<Color>(Theme.of(context).buttonTheme.colorScheme?.primary.withOpacity(0.15) ?? Colors.amber),
        ),
        label: Skeleton.ignore(
          child: Text.rich(
            style: const TextStyle(fontSize: 16),
            TextSpan(children: [
              TextSpan(text: '${item.label} \n'),
              TextSpan(text: item.descriptiveValue, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ]),
          ),
        ),
      ),
    );
  }
}
