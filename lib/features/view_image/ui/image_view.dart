import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final String? heroTag;
  final String image;
  final bool isNetwork;

  const ImageView(
      {Key? key,
      required this.heroTag,
      required this.image,
      this.isNetwork = true})
      : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Hero(
                tag: widget.heroTag ?? '', child: Image.network(widget.image)),
          )),
    );
  }
}
