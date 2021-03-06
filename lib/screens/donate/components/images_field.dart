import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:centavo_tcc/screens/donate/components/image_source_modal.dart';
import 'package:centavo_tcc/stores/donate_store.dart';

import 'image_dialog.dart';

class ImagesField extends StatelessWidget {
  ImagesField(this.donateStore);

  final DonateStore donateStore;

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File image) {
      donateStore.images.add(image);
      Navigator.of(context).pop();
    }

    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          height: 120,
          child: Observer(builder: (_) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: donateStore.images.length < 5
                  ? donateStore.images.length + 1
                  : 5,
              itemBuilder: (_, index) {
                if (index == donateStore.images.length)
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                    child: GestureDetector(
                      onTap: () {
                        if (Platform.isAndroid) {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => ImageSourceModal(onImageSelected),
                          );
                        } else {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (_) => ImageSourceModal(onImageSelected),
                          );
                        }
                      },
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                else
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                      8,
                      16,
                      index == 4 ? 8 : 0,
                      16,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => ImageDialog(
                            image: donateStore.images[index],
                            onDelete: () => donateStore.images.removeAt(index),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 44,
                        backgroundImage: donateStore.images[index] is File
                            ? FileImage(
                                donateStore.images[index],
                              )
                            : NetworkImage(donateStore.images[index]),
                      ),
                    ),
                  );
              },
            );
          }),
        ),
        Observer(builder: (_) {
          if (donateStore.imagesError != null)
            return Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.red)),
              ),
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
              child: Text(donateStore.imagesError,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  )),
            );
          else
            return Container();
        }),
      ],
    );
  }
}
