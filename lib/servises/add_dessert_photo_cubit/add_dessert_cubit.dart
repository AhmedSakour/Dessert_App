import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/dessertModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import '../../widgets/custom_result_dialog.dart';

part 'add_dessert_state.dart';

class AddDessertCubit extends Cubit<AddDessertStates> {
  AddDessertCubit() : super(AddDessertInitial());
  File? selectImage;
  File? get selectedImage => selectImage;

  Future getImage() async {
    emit(GetDessertPhotoLoading());
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectImage = File(image.path);
      }
      emit(GetDessertPhotoSuccess());
      return selectImage;
    } on Exception {
      emit(GetDessertPhotoFailure());
    }
  }

  addDessert(String dessertName, DessertModel dessertModel, context) async {
    emit(AddDessertLoading());
    if (selectImage != null) {
      try {
        String imageId = randomAlphaNumeric(10);
        Reference reference =
            FirebaseStorage.instance.ref().child('blogImage').child(imageId);
        final UploadTask uploadTask = reference.putFile(selectImage!);
        var downloadurl = await (await uploadTask).ref.getDownloadURL();
        Map<String, dynamic> infoDessert = {
          'Image': downloadurl,
          'Name': dessertModel.name,
          'Price': dessertModel.price,
          'Detail': dessertModel.description,
          'ViewedBy': dessertModel.viewedBy,
          'id': dessertModel.id,
        };
        await FirebaseFirestore.instance
            .collection(dessertName)
            .add(infoDessert);

        emit(AddDessertSuccess());
      } on Exception {
        customResultDilogo(context,
            data: 'There\'s a error',
            dataButton: 'ok',
            icon: Icons.error,
            colorIcon: Colors.red);
        emit(AddDessertFailure());
      }
    }
  }
}
