import 'package:dailynotes/customwidgets/utils.dart';
import 'package:dailynotes/providers/loginprovider.dart';
import 'package:dailynotes/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'screens/splash.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
final navigatorKey =GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<LoginProvider>(create: (_)=>LoginProvider(FirebaseAuth.instance)),
       //   StreamProvider(create: (context)=> context.read<LoginProvider>().authStateChanges, initialData: User,)
        ],
        child:  ScreenUtilInit(
            designSize: const Size(360,690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context , child){
              return  MaterialApp(
                navigatorKey: navigatorKey,
                scaffoldMessengerKey: Utils.messengerKey,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  fontFamily: 'Lato',
                  primarySwatch: Colors.blue,
                ),
                home: const AuthendicationWrapper(),
              );
            }));
  }
}
class AuthendicationWrapper extends StatelessWidget {
  const AuthendicationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if (snapshot.connectionState==ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if(snapshot.hasError) {
              return   const Center(
                child: Text("Something went Wrorng"),
              );
            } else if(snapshot.hasData){
              return const HomePage();
            }else{
              return const SplashScreen();
            }
          }
      ),
    );
  }
}