import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/Screens/initial_screen.dart';
import 'package:my_first_app/blocProvider/todo_bloc.dart';
import 'package:my_first_app/firebase_options.dart';

final messangerkey = GlobalKey<ScaffoldMessengerState>();

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // FireBase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize hive
  // await Hive.initFlutter();

  //Register the adapter
  // Hive.registerAdapter(TodoAdapter());

  // Open the peopleBox
  // await Hive.openBox(boxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // ChangeNotifierProvider(
        //   create: (context) => CountProvider(),
        // ChangeNotifierProvider(
        //   create: (context) => CountProvider(),
        //or
        //   MultiProvider(
        // providers: [
        //   ChangeNotifierProvider(create: (context) => CartProvider()),
        //   ChangeNotifierProvider(create: (context) => AuthProvider()),
        //   ChangeNotifierProvider(create: (context) => UserProvider()),
        // ],
        MultiBlocProvider(
      providers: [BlocProvider(create: (context) => TodoBloc())],
      child: MaterialApp(
        navigatorKey: navigatorKey,

        scaffoldMessengerKey: messangerkey,
        debugShowCheckedModeBanner: false,
        title: "Clone",
        theme: ThemeData(
          // fontFamily: 'RopaSans',
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        // home: const App(
        //   name: 'login',
        // ),
        // home: const StatefulWidgetScreen(),
        // home: const MyButtons(),
        // home: const WhatsAppLandingScreen(),
        // home: const WrapWidgetScreen(),
        // home: const CardWeidget(),
        // home: const TableScreen(),
        // home: const ListTileScreen(),
        // home: const AspectRatioScreen(),
        // home: const BaseLineScreen(),
        // home: const TonyStarkScreen(),
        // home: const FlutterSatTest(),
        // home: const GridViewScreen(),
        // home: const SilverAppBarScreen(),
        // home: const FbLandingScreen(),
        // home: const ConsumerProductScreen(),
        // home: const SelectorProductScreen(),
        // home: const LoginScreen(), //Post Api screen
        // home: const ApiUserScreen(),
        // home: const CounterScreenProvider(),
        // home: const CounterScreensPractice(),
        // home: const ButtonCircle(),
        // home: const RandomUserScreen(),
        // home: const ListScreen(),
        // home: const FormScreen(),
        // home: const ImagePickerScreen(),
        // home: const AdvanceWidgetScrreen(),
        // home: const RoatedBoxScreen(),
        // home: const PageViewScreen(),
        // home: const CustomPaintScreen(),
        // home: const ClipperScreen(),
        // home: const AdvanceMaterialWidget(),
        // home: const LocalStorageScreen(),
        // home: const ToDoScreen(),
        // home: const HiveToDoScreen(),
        // home: const ImagePickerLocalStorageScreen(),
        // home: const ApiPaginationUserScreen(),
        // home: const SharedPreScreen(),
        // home: const FirebaseLoginScreen(),
        home: const InitialScreen(),
        //Animation
        // home: const AnimatedAlignExample(),
        // home: const HeroWidgetAnimation(),
        // home:  AnimationContainer(),
        // home: const TrickerProviderAnimation(),
        // home: const AnimatedCrossFadeScreen(),
        // home: const AnimateddefaultText(),
        // home: const LikeTweenAnimation(),
        // home: const AnimationListScreen(),
        // home: const StaggredAnimationScreen(),
      ),
    );
  }
}
