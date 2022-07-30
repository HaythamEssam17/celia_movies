import 'package:celia_movies/Constants/app_constants.dart';
import 'package:celia_movies/Constants/shared_functions.dart';
import 'package:celia_movies/Helpers/Routes/route_arguments.dart';
import 'package:celia_movies/Helpers/shared_texts.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/Images_Cubit/image_cubit.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/Images_Cubit/image_states.dart';
import 'package:celia_movies/Presentations/Widgets/common_cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageViewPage extends StatefulWidget {
  final RouteArguments routeArguments;

  const ImageViewPage({Key? key, required this.routeArguments})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  late ImageCubit _imageCubit;

  @override
  void initState() {
    super.initState();
    _imageCubit = BlocProvider.of<ImageCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.mainColor,
      body: SizedBox(
        height: SharedText.screenHeight,
        width: SharedText.screenWidth,
        child: BlocListener<ImageCubit, ImageStates>(
          child: Stack(
            fit: StackFit.expand,
            children: [
              commonCachedImageWidget(context, widget.routeArguments.imagePath!,
                  height: SharedText.screenHeight,
                  width: SharedText.screenWidth * 2,
                  fit: BoxFit.fill,
                  radius: 0.0),
              Positioned(
                // alignment: Alignment.bottomCenter,
                bottom: 25,
                right: 25,
                child: ClipOval(
                  child: Container(
                    color: AppConstants.greenColor,
                    child: IconButton(
                      onPressed: () async {
                        await _imageCubit
                            .saveImage(widget.routeArguments.imagePath!);
                      },
                      icon: const Icon(
                        Icons.download,
                        color: AppConstants.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),

              /// Back Button
              Positioned(
                top: 25,
                left: 25,
                child: ClipOval(
                  child: Container(
                    color: AppConstants.blueColor,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppConstants.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),

              /// Loading
              Center(
                // top: SharedText.screenHeight / 2,
                // left: SharedText.screenWidth / 2,
                child: ValueListenableBuilder(
                  valueListenable: _imageCubit.showLoader,
                  builder: (context, value, child) {
                    return _imageCubit.showLoader.value
                        ? ClipOval(
                            child: Container(
                              height: getWidgetHeight(100),
                              width: getWidgetHeight(100),
                              color: AppConstants.whiteColor,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          )
                        : const SizedBox();
                  },
                ),
              ),
            ],
          ),
          // builder: (context, state) {
          //   return Stack(
          //     fit: StackFit.expand,
          //     children: [
          //       commonCachedImageWidget(
          //           context, widget.routeArguments.imagePath!,
          //           height: SharedText.screenHeight,
          //           width: SharedText.screenWidth * 2,
          //           fit: BoxFit.fill,
          //           radius: 0.0),
          //       Positioned(
          //         // alignment: Alignment.bottomCenter,
          //         bottom: 25,
          //         right: 25,
          //         child: ClipOval(
          //           child: Container(
          //             color: AppConstants.greenColor,
          //             child: IconButton(
          //               onPressed: () async {
          //                 await _imageCubit
          //                     .saveImage(widget.routeArguments.imagePath!);
          //               },
          //               icon: const Icon(
          //                 Icons.download,
          //                 color: AppConstants.whiteColor,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //
          //       /// Back Button
          //       Positioned(
          //         top: 25,
          //         left: 25,
          //         child: ClipOval(
          //           child: Container(
          //             color: AppConstants.blueColor,
          //             child: IconButton(
          //               onPressed: () => Navigator.pop(context),
          //               icon: const Icon(
          //                 Icons.arrow_back,
          //                 color: AppConstants.whiteColor,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //
          //       ValueListenableBuilder(
          //           valueListenable: _imageCubit.showLoader,
          //           builder: (context, value, child) {
          //             return _imageCubit.showLoader.value
          //                 ? Container(
          //                     height: getWidgetHeight(100),
          //                     width: getWidgetHeight(100),
          //                     color: AppConstants.whiteColor,
          //                     child: const Center(
          //                       child: CircularProgressIndicator(),
          //                     ),
          //                   )
          //                 : const SizedBox();
          //           }),
          //     ],
          //   );
          // },
          listener: (context, state) {
            if (state is DownloadingImageLoading) {
            } else if (state is DownloadingImageSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Image Saved Successfully.')));
            } else if (state is DownloadingImageFailed) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Failed to save image.'),
                backgroundColor: AppConstants.redColor,
              ));
            }
          },
        ),
      ),
    );
  }
}
