import 'package:celia_movies/Constants/app_constants.dart';
import 'package:celia_movies/Helpers/app_logs.dart';
import 'package:celia_movies/Helpers/shared_texts.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/Connectivity_Cubit/connectivity_cubit.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/People_Cubit/people_cubit.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/People_Cubit/people_states.dart';
import 'package:celia_movies/Presentations/Widgets/HomeWidgets/person_card_widget.dart';
import 'package:celia_movies/Presentations/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PeopleCubit _peopleCubit;

  @override
  void initState() {
    super.initState();
    _peopleCubit = BlocProvider.of<PeopleCubit>(context);
    _peopleCubit.persons.clear();
    _peopleCubit.fetchAllPopularPeople();

    _peopleCubit.scrollController = ScrollController();
    _peopleCubit.scrollController.addListener(
      () {
        _peopleCubit.setupScrollController();
      },
    );
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (context.watch<ConnectivityCubit>().getConnectionStatus ==
  //       'ConnectivityResult.none') {
  //     logPrint('ConnectivityResult.none');
  //     _peopleCubit.fetchLocalData(context);
  //   } else {
  //     _peopleCubit.persons.clear();
  //     _peopleCubit.fetchAllPopularPeople();
  //
  //     _peopleCubit.scrollController = ScrollController();
  //     _peopleCubit.scrollController.addListener(
  //       () {
  //         _peopleCubit.setupScrollController();
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (context.watch<ConnectivityCubit>().getConnectionStatus ==
        'ConnectivityResult.none') {
      logPrint('ConnectivityResult.none');
      _peopleCubit.fetchLocalData(context);
    } else {
      _peopleCubit.persons.clear();
      _peopleCubit.fetchAllPopularPeople();

      _peopleCubit.scrollController = ScrollController();
      _peopleCubit.scrollController.addListener(
        () {
          _peopleCubit.setupScrollController();
        },
      );
    }

    return Scaffold(
      backgroundColor: AppConstants.mainColor,
      appBar: AppBar(
        backgroundColor: AppConstants.mainColor,
        elevation: 0.0,
        title: const Text('Celia Movie'),
      ),
      body: context.read<ConnectivityCubit>().getConnectionStatus ==
              'ConnectivityResult.none'
          ? Column(
              children: [
                const CommonTitleText(
                  textKey: 'No Internet Connection',
                  textFontSize: AppConstants.mediumFontSize,
                  textColor: AppConstants.whiteColor,
                ),
                Expanded(
                  child: BlocConsumer<PeopleCubit, PeopleStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      debugPrint('FetchPeoplesLocalState');
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.9,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return PersonCardWidget(
                              personModel: context
                                  .read<PeopleCubit>()
                                  .getLocalPersons[index]);
                        },
                        itemCount:
                            context.read<PeopleCubit>().getLocalPersons.length,
                        shrinkWrap: true,
                        controller: _peopleCubit.scrollController,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                      );
                    },
                  ),
                ),
              ],
            )
          : SizedBox(
              height: SharedText.screenHeight,
              width: SharedText.screenWidth,
              child: BlocConsumer<PeopleCubit, PeopleStates>(
                listener: (context, state) {
                  if (state is FetchPeoplesLocalState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: CommonTitleText(
                        textKey: context
                            .read<PeopleCubit>()
                            .getLocalPersons
                            .length
                            .toString(),
                        textFontSize: AppConstants.mediumFontSize,
                        textColor: AppConstants.whiteColor,
                      ),
                    ));
                  }

                  if (state is FetchPeoplesMoreDataState) {
                    _peopleCubit.isLoadingMorePeople = true;
                  } else {
                    _peopleCubit.isLoadingMorePeople = false;
                  }
                },
                builder: (context, state) {
                  if (state is PeopleLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PeopleFailedState) {
                    return Center(
                      child: CommonTitleText(
                        textKey: state.error.toString(),
                        textColor: AppConstants.whiteColor,
                        textFontSize: AppConstants.mediumFontSize,
                        lines: 5,
                      ),
                    );
                  } else if (state is PeopleSuccessState) {
                    return RefreshIndicator(
                      onRefresh: context.watch<PeopleCubit>().onRefresh,
                      color: AppConstants.mainColor,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.9,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          /// Pagination Loading
                          if (index + 1 >= _peopleCubit.persons.length &&
                              _peopleCubit.isLoadingMorePeople) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return PersonCardWidget(
                              personModel:
                                  context.read<PeopleCubit>().persons[index]);
                        },
                        itemCount: context.read<PeopleCubit>().persons.length,
                        shrinkWrap: true,
                        controller: _peopleCubit.scrollController,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
    );
  }
}
