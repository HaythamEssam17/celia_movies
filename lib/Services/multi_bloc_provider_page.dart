import 'package:celia_movies/Data/Remote/Repositories/image_repository.dart';
import 'package:celia_movies/Data/Remote/Repositories/popular_people_repository.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/Connectivity_Cubit/connectivity_cubit.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/Images_Cubit/image_cubit.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/People_Cubit/people_cubit.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/Person_Details_Cubit/person_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBlocProvidersPage extends StatefulWidget {
  final Widget body;

  const MultiBlocProvidersPage({Key? key, required this.body})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiBlocProvidersPageState();
}

class _MultiBlocProvidersPageState extends State<MultiBlocProvidersPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityCubit>(
            lazy: false, create: (_) => ConnectivityCubit()..initConnection()),
        BlocProvider<PeopleCubit>(
            lazy: false, create: (_) => PeopleCubit(PopularPeopleRepository())),
        BlocProvider<PersonDetailsCubit>(
            lazy: false,
            create: (_) => PersonDetailsCubit(PopularPeopleRepository())),
        BlocProvider<ImageCubit>(
            lazy: false, create: (_) => ImageCubit(ImageRepository())),
      ],
      child: widget.body,
    );
  }
}
