import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: width * 0.8,
          child: TextField(
            onTap: () {
            
            },
            cursorColor: black,
            decoration: InputDecoration(
              fillColor: white,
              filled: true,
              hintText: 'Search Permis111.in',
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: black,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () {},
                
                icon: Icon(
                  Icons.camera_alt_sharp,
                  color: grey,
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: width * 0.03),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: grey),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: grey),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: grey),
              ),
            ),
            
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.mic,
            color: black,
          ),
        ),
      ],
    );
  }
}