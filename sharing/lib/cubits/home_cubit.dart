import 'dart:io';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharing/services/image_service.dart';
import 'package:sharing/utils/share_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ImageService imageService;
  final ShareHelper shareHelper;

  HomeCubit(this.imageService, this.shareHelper)
    : super(HomeState(imageUrl: "https://picsum.photos/400/600?random=1"));

  Future<void> changeImage() async {
    emit(state.copyWith(isDownloading: true, message: null));

    try {
      // Generate random URL
      final randomInt = Random().nextInt(1000);
      final newUrl = "https://picsum.photos/400/600?random=$randomInt";

      // Download the new image immediately
      final file = await imageService.downloadImage(newUrl);

      // Delete old file (cleanup)
      if (state.localImage != null && await state.localImage!.exists()) {
        await state.localImage!.delete();
      }

      emit(
        state.copyWith(
          imageUrl: newUrl,
          localImage: file,
          isDownloading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(isDownloading: false, message: "Error loading image"),
      );
    }
  }

  Future<void> shareText() async {
    try {
      await shareHelper.shareText(
        'Hey, what do you think of this image (${state.imageUrl})?!',
      );
      emit(state.copyWith(message: "Text shared successfully!"));
    } catch (e) {
      emit(state.copyWith(message: "Error sharing text: $e"));
    }
  }

  Future<void> shareImage() async {
    if (state.localImage == null) {
      emit(state.copyWith(message: "No image to share"));
      return;
    }

    try {
      await shareHelper.shareFile(state.localImage!);
      emit(state.copyWith(message: "Image shared successfully!"));
    } catch (e) {
      emit(state.copyWith(message: "Error sharing image: $e"));
    }
  }
}
