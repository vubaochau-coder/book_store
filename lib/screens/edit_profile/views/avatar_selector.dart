import 'dart:io';

import 'package:book_store/screens/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AvatarSelector extends StatelessWidget {
  const AvatarSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) {
        return previous.newAvatar != current.newAvatar;
      },
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: state.newAvatar == null
                  ? CachedNetworkImage(
                      imageUrl: state.avtURL,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.file(
                          state.newAvatar!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            Positioned(
              left: 104,
              right: 0,
              bottom: 18,
              child: GestureDetector(
                onTap: () async {
                  await ImagePicker()
                      .pickImage(source: ImageSource.gallery)
                      .then((value) {
                    if (value == null) return;

                    final imageTemporary = File(value.path);

                    BlocProvider.of<EditProfileBloc>(context).add(
                      UpdateAvatarEvent(avatar: imageTemporary),
                    );
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[100],
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 24,
                    color: Colors.black54,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
