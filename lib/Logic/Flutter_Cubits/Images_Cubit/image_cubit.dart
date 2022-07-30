import 'package:celia_movies/Data/Interfaces/image_interface.dart';
import 'package:celia_movies/Data/Models/image_model.dart';
import 'package:celia_movies/Helpers/app_logs.dart';
import 'package:celia_movies/Logic/Flutter_Cubits/Images_Cubit/image_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ImageCubit extends Cubit<ImageStates> {
  final IImageInterface _iImageInterface;

  ValueNotifier<bool> showLoader = ValueNotifier(false);

  List<Profile> profiles = [];

  ImageCubit(this._iImageInterface) : super(ImageInitState());

  fetchImagesByPersonID(int personID) async {
    try {
      profiles.clear();
      emit(ImageLoadingState());

      var result = await _iImageInterface.fetchAllImages(personID: personID);

      if (_iImageInterface.isError) {
        emit(ImageFailedState(
            error: _iImageInterface.errorMsg!.errorMassage!.toString()));
      } else {
        for (var i in result.profiles!) {
          profiles.add(i);
        }

        emit(ImageSuccessState());
      }
    } catch (e) {
      emit(ImageFailedState(error: e.toString()));
    }
  }

  saveImage(String imagePath) async {
    showLoader.value = true;
    emit(DownloadingImageLoading());

    var result = await GallerySaver.saveImage(imagePath).then((value) {
      return value;
    });

    if (result!) {
      showLoader.value = false;
      logPrint('image saved successfully.');
      emit(DownloadingImageSuccess());
    } else {
      showLoader.value = false;
      emit(DownloadingImageFailed('Failed to save image.'));
    }
  }
}
