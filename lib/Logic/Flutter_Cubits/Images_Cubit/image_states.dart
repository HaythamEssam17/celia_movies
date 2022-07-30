abstract class ImageStates {}

class ImageInitState extends ImageStates {}

class ImageLoadingState extends ImageStates {}

class ImageSuccessState extends ImageStates {}

class ImageFailedState extends ImageStates {
  final String error;

  ImageFailedState({required this.error});
}

class DownloadingImageLoading extends ImageStates {}

class DownloadingImageSuccess extends ImageStates {}

class DownloadingImageFailed extends ImageStates {
  final String error;

  DownloadingImageFailed(this.error);
}
