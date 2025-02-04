import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:leafy_demo/src/models/state/user_state_model.dart';
import 'package:leafy_demo/src/screens/plants/plant_details_view.dart';
import 'package:leafy_demo/src/state/filter_state.dart';
import 'package:leafy_demo/src/state/user_state.dart';
import 'package:provider/provider.dart';

import 'screens/authentication/user_login_view.dart';
import 'screens/plants/plant_list_view.dart';
import 'screens/users/user_register_view.dart';
import 'services/storage/user.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'state/global_state.dart';
import 'state/plant_state.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isUserAuthenticated(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        // Determine the initial route based on authentication status
        final initialRoute = snapshot.data == true
            ? PlantListView.routeName // Main app screen
            : UserLoginView.routeName; // Authentication screen

        return MultiProvider(
          providers: [
            ChangeNotifierProvider<GlobalModel>(
              create: (context) => GlobalModel(),
            ),
            ChangeNotifierProvider<FilterModel>(
              create: (context) => FilterModel(),
            ),
            ChangeNotifierProxyProvider<GlobalModel, UserModel>(
              create: (context) => UserModel(info: UserStateModel.empty(), globalModel: Provider.of<GlobalModel>(context, listen: false)),
              update: (context, globalModel, userModel) => userModel!..setGlobalModel(globalModel),
            ),
            ChangeNotifierProxyProvider2<GlobalModel, FilterModel, PlantModel>(
              create: (context) => PlantModel(globalModel: Provider.of<GlobalModel>(context, listen: false), filterModel: Provider.of<FilterModel>(context, listen: false)),
              update: (context, globalModel, filterModel, plantModel) => plantModel!..setModels(globalModel, filterModel),
            ),
            ChangeNotifierProvider(
              create: (_) => settingsController,
            ),
          ],
          child: ListenableBuilder(
            listenable: settingsController,
            builder: (BuildContext context, Widget? child) {
              return MaterialApp(
                restorationScopeId: 'app',

                // Provide the generated AppLocalizations to the MaterialApp. This
                // allows descendant Widgets to display the correct translations
                // depending on the user's locale.
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''), // English, no country code
                ],
                
                // Use AppLocalizations to configure the correct application title
                // depending on the user's locale.
                onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,

                // Define a light and dark color theme. Then, read the user's
                // preferred ThemeMode (light, dark, or system default) from the
                // SettingsController to display the correct theme.
                theme: ThemeData.from(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color.fromARGB(255, 52, 93, 95),
                    surface: const Color.fromRGBO(241, 245, 249, 1),
                    primary: const Color.fromARGB(255, 52, 93, 95),
                  ),
                ),
                darkTheme: ThemeData.dark(),
                themeMode: settingsController.themeMode,

                // redirect user to login if not authenticated. Check on every route change
                navigatorObservers: [
                  // ignore: prefer_const_constructors
                  RouteObserver(),
                ],

                // Define a function to handle named routes in order to support
                // Flutter web url navigation and deep linking.
                initialRoute: initialRoute,
                onGenerateRoute: (RouteSettings routeSettings) {
                  return MaterialPageRoute<void>(
                    settings: routeSettings,
                    builder: (BuildContext context) {
                      switch (routeSettings.name) {
                        case SettingsView.routeName:
                          return SettingsView(controller: settingsController);
                        case PlantMoreDetailsView.routeName:
                          return const PlantMoreDetailsView();
                        case UserLoginView.routeName:
                          return UserLoginView();
                        case UserRegisterView.routeName:
                          return UserRegisterView();
                        case PlantListView.routeName:
                          return PlantListView();
                        default:
                          return UserLoginView();
                      }
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<bool> _isUserAuthenticated() async {
    final token = await UserStorage().accessToken.get();

    return token != null && token.isNotEmpty;
  }
}
