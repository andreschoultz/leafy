import 'package:flutter/material.dart';
import 'package:leafy_demo/src/state/plant_state.dart';
import 'package:provider/provider.dart';

import 'plant_list/plant_list_bottom_appbar_widget.dart';
import 'plant_list/plant_list_widget.dart';

class PlantListView extends StatefulWidget {
  const PlantListView({
    super.key,
  });

  static const routeName = '/plant/list';

  @override
  State<PlantListView> createState() => _PlantListViewState();
}

class _PlantListViewState extends State<PlantListView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<PlantModel>(context, listen: false).getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(241, 245, 249, 1),
          surfaceTintColor: const Color.fromRGBO(241, 245, 249, 1),
          automaticallyImplyLeading: false,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Create',
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
          backgroundColor: Colors.white,
          foregroundColor: Colors.indigo,
          child: const Icon(Icons.flip),
        ),
        bottomNavigationBar: const PlantListBottomAppBar(
          fabLocation: FloatingActionButtonLocation.centerDocked,
          shape: CircularNotchedRectangle(),
        ),
        body: Container(padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 26), child: PlantListItemView()),
      ),
    );
  }
}
