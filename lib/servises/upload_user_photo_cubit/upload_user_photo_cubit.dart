import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';

import '../sharedPref.dart';
import 'package:image_picker/image_picker.dart';
part 'upload_user_photo_state.dart';

class UploadUserPhotoCubit extends Cubit<UploadPhotoState> {
  UploadUserPhotoCubit() : super(UploadPhotoInitial());
  File? selectImage;
  String? imageProfile;

  getImageFromSharedPref() async {
    try {
      imageProfile = await SharedPrefHelper().getUserProfileImage();
    } on Exception {}
  }

  Future getImage() async {
    emit(GetPhotoLoading());
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectImage = File(image.path);
      }
      emit(GetPhotoSuccess());
    } on Exception {
      emit(GetPhotoFailure());
    }
  }

  uploadImage(
    String id,
  ) async {
    emit(UploadPhotoLoading());
    if (selectImage != null) {
      try {
        String imageId = randomAlphaNumeric(10);
        Reference reference =
            FirebaseStorage.instance.ref().child('blogImage').child(imageId);
        final UploadTask uploadTask = reference.putFile(selectImage!);
        var downloadurl = await (await uploadTask).ref.getDownloadURL();

        await SharedPrefHelper().saveUserProfileImage(downloadurl);
        await FirebaseFirestore.instance.collection('users').doc(id).update({
          'Image': downloadurl,
        });
        await getImageFromSharedPref();

        emit(UploadPhotoSuccess());
      } on Exception {
        emit(UploadPhotoFailure());
      }
    }
  }
}
