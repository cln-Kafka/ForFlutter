import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharing/cubits/home_cubit.dart';
import 'package:sharing/services/image_service.dart';
import 'package:sharing/utils/share_helper.dart';
import 'package:sharing/widgets/custom_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = HomeCubit(ImageService(), ShareHelper());
        cubit.changeImage(); // fetch an image immediately on startup
        return cubit;
      },
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final cubit = context.read<HomeCubit>();
            return Scaffold(
              appBar: AppBar(
                title: const Text('Sharing Example'),
                centerTitle: true,
              ),

              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          state.localImage != null
                              ? Image.file(state.localImage!, fit: BoxFit.cover)
                              : const Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ],
                                ),
                          Positioned(
                            child: IconButton(
                              onPressed: cubit.changeImage,
                              icon: Icon(Icons.refresh),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomButton(
                        buttonText: "Share only the image URL",
                        onPressed: cubit.shareText,
                      ),
                      CustomButton(
                        buttonText: state.isDownloading
                            ? "Downloading..."
                            : "Share image",
                        onPressed: state.isDownloading
                            ? null
                            : cubit.shareImage,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
