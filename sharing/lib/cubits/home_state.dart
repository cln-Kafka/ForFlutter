part of 'home_cubit.dart';

class HomeState {
  final String imageUrl;
  final File? localImage;
  final bool isDownloading;
  final String? message;

  HomeState({
    required this.imageUrl,
    this.localImage,
    this.isDownloading = false,
    this.message,
  });

  HomeState copyWith({
    String? imageUrl,
    File? localImage,
    bool? isDownloading,
    String? message,
  }) {
    return HomeState(
      imageUrl: imageUrl ?? this.imageUrl,
      localImage: localImage ?? this.localImage,
      isDownloading: isDownloading ?? this.isDownloading,
      message: message,
    );
  }
}
