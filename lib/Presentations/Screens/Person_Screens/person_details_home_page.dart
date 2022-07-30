import 'package:celia_movies/Constants/Keys/movie_db_keys.dart';
import 'package:celia_movies/Constants/app_constants.dart';
import 'package:celia_movies/Constants/shared_functions.dart';
import 'package:celia_movies/Helpers/Routes/route_arguments.dart';
import 'package:celia_movies/Helpers/Routes/route_names.dart';
import 'package:celia_movies/Helpers/shared_texts.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/Connectivity_Cubit/connectivity_cubit.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/Images_Cubit/image_cubit.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/Images_Cubit/image_states.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/Person_Details_Cubit/person_details_cubit.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/Person_Details_Cubit/person_details_states.dart';
import 'package:celia_movies/Presentations/Widgets/common_cached_image_widget.dart';
import 'package:celia_movies/Presentations/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonDetailsHomePage extends StatefulWidget {
  final RouteArguments routeArguments;

  const PersonDetailsHomePage({Key? key, required this.routeArguments})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PersonDetailsHomePageState();
}

class _PersonDetailsHomePageState extends State<PersonDetailsHomePage> {
  late PersonDetailsCubit _personDetailsCubit;
  late ImageCubit _imageCubit;

  @override
  void initState() {
    super.initState();
    _personDetailsCubit = BlocProvider.of<PersonDetailsCubit>(context);
    _imageCubit = BlocProvider.of<ImageCubit>(context);

    _personDetailsCubit.getPersonDetailsByID(widget.routeArguments.personID!);

    _imageCubit.fetchImagesByPersonID(widget.routeArguments.personID!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.mainColor,
      appBar: AppBar(
        backgroundColor: AppConstants.mainColor,
      ),
      body: context.read<ConnectivityCubit>().connectionStatus ==
              'ConnectivityResult.none'
          ? const Center(
              child: CommonTitleText(
                textKey: 'No Internet Connection',
                textFontSize: AppConstants.mediumFontSize,
                textColor: AppConstants.whiteColor,
              ),
            )
          : SizedBox(
              height: SharedText.screenHeight,
              width: SharedText.screenWidth,
              child: BlocBuilder<PersonDetailsCubit, PersonDetailsStates>(
                builder: (context, state) {
                  if (state is PersonDetailsLoadingStates) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PersonDetailsFailedStates) {
                    return Center(
                      child: CommonTitleText(
                        textKey: state.error.toString(),
                        textColor: AppConstants.whiteColor,
                        textFontSize: AppConstants.mediumFontSize,
                        lines: 5,
                      ),
                    );
                  } else if (state is PersonDetailsSuccessStates) {
                    return Column(
                      children: [
                        commonCachedImageWidget(
                          context,
                          MovieDBKeys.imagePathUrl +
                              _personDetailsCubit
                                  .personDetailsModel.profilePath!,
                          fit: BoxFit.fill,
                          width: SharedText.screenWidth,
                          height: getWidgetHeight(350),
                          radius: 0.0,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Actor Name
                                Row(
                                  children: [
                                    CommonTitleText(
                                      textKey: _personDetailsCubit
                                          .personDetailsModel.name!,
                                      textColor: AppConstants.whiteColor,
                                      textFontSize: AppConstants.xLargeFontSize,
                                      lines: 5,
                                    ),
                                    CommonTitleText(
                                      textKey: ' ( ' +
                                          _personDetailsCubit.personDetailsModel
                                              .knownForDepartment! +
                                          ' ) ',
                                      textColor: AppConstants.whiteColor,
                                      textFontSize: AppConstants.smallFontSize,
                                      lines: 5,
                                    ),
                                  ],
                                ),
                                getSpaceHeight(15),

                                /// Birth Place
                                CommonTitleText(
                                  textKey: _personDetailsCubit
                                      .personDetailsModel.placeOfBirth!,
                                  textColor: AppConstants.blueColor,
                                  textFontSize: AppConstants.largeFontSize,
                                  lines: 10,
                                ),
                                getSpaceHeight(15),

                                /// Actor Birthdate
                                Row(
                                  children: [
                                    CommonTitleText(
                                      textKey: formattedDate(_personDetailsCubit
                                          .personDetailsModel.birthday!),
                                      textColor: AppConstants.whiteColor,
                                      textFontSize: AppConstants.normalFontSize,
                                      lines: 5,
                                    ),
                                    CommonTitleText(
                                      textKey: ' ( ' +
                                          calculateAge(_personDetailsCubit
                                                  .personDetailsModel.birthday!)
                                              .toString() +
                                          ' age ) ',
                                      textColor: AppConstants.whiteColor,
                                      textFontSize: AppConstants.smallFontSize,
                                      lines: 5,
                                    ),
                                  ],
                                ),
                                getSpaceHeight(15),

                                /// Line
                                Container(
                                    height: getWidgetHeight(1),
                                    width: SharedText.screenWidth,
                                    color: AppConstants.secondMainColor),
                                getSpaceHeight(15),

                                /// Actor Biography
                                ...[
                                  const CommonTitleText(
                                    textKey: 'Biography',
                                    textColor: AppConstants.whiteColor,
                                    textFontSize: AppConstants.largeFontSize,
                                    lines: 10,
                                  ),
                                  getSpaceHeight(15),
                                  CommonTitleText(
                                    textKey: _personDetailsCubit
                                        .personDetailsModel.biography!,
                                    textColor: AppConstants.whiteColor,
                                    textFontSize: AppConstants.normalFontSize,
                                    lines: 10,
                                  ),
                                ],
                                getSpaceHeight(15),

                                /// Line
                                Container(
                                    height: getWidgetHeight(1),
                                    width: SharedText.screenWidth,
                                    color: AppConstants.secondMainColor),
                                getSpaceHeight(15),

                                /// Actor Images
                                ...[
                                  const CommonTitleText(
                                    textKey: 'Images',
                                    textColor: AppConstants.whiteColor,
                                    textFontSize: AppConstants.largeFontSize,
                                    lines: 10,
                                  ),
                                  getSpaceHeight(15),

                                  /// View Actor images
                                  BlocConsumer<ImageCubit, ImageStates>(
                                    listener: (context, state) {},
                                    builder: (context, state) {
                                      if (state is ImageLoadingState) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (state is ImageFailedState) {
                                        return Center(
                                          child: CommonTitleText(
                                            textKey: state.error,
                                            textColor: AppConstants.whiteColor,
                                          ),
                                        );
                                      }
                                      return GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 1,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  RouteNames.imageViewPageRoute,
                                                  arguments: RouteArguments(
                                                      imagePath: MovieDBKeys
                                                              .imagePathUrl +
                                                          _imageCubit
                                                              .profiles[index]
                                                              .filePath!));
                                            },
                                            child: commonCachedImageWidget(
                                                context,
                                                MovieDBKeys.imagePathUrl +
                                                    _imageCubit.profiles[index]
                                                        .filePath!,
                                                fit: BoxFit.fill,
                                                radius: 10),
                                          );
                                        },
                                        itemCount: _imageCubit.profiles.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                      );
                                    },
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
    );
  }
}
