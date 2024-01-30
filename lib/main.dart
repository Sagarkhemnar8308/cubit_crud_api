import 'package:crud_bloc_api/logic/getcubit/get_api_cubit.dart';
import 'package:crud_bloc_api/presentation/getApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetApiCubit(),
        ),
       
      ],
      child: const  MaterialApp(
        debugShowCheckedModeBanner: false,
        home:GetApi(),
      ),
    ) ;
  }
}
