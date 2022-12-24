
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_testing/Globals/providers.dart';
import 'package:firebase_testing/Pages/AuthPages/VerifyEmail.dart';
import 'package:firebase_testing/Pages/Home/HomeScreen.dart';
import 'package:firebase_testing/Utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'Pages/AuthPages/AuthPage.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (_) => Page_pr(),

      child: MaterialApp(
    
        navigatorKey: Utils.navigatorKey,
        scaffoldMessengerKey: Utils.messengerKey,
    
        theme: ThemeData(primarySwatch: Colors.orange),
    
        debugShowCheckedModeBanner: false,
    
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin<MainScreen> {

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(

      child: StreamBuilder<User?>(
       
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
         
          if(snapshot.hasError){
            return Center(child: Text('Something went wrong!', style: TextStyle(fontSize: 50, color: Colors.red.shade700),),);
          }
          else if(snapshot.hasData){
            return const HomeScreen();
          }
          else{
            return const AuthPage();
          }
        }
      ),
    );
  }
}