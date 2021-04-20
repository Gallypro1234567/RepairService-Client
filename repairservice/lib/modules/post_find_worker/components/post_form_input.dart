import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostFormInput extends StatelessWidget {
  final String title;
  final String hintText;
  final Function(String) onChanged;
  const PostFormInput({Key key, this.title, this.hintText, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextFormField(
        onChanged: onChanged,
        scrollPadding: const EdgeInsets.symmetric(vertical: 0.0),
        decoration: InputDecoration(
          labelText: '$title *',
          hintText: hintText, 
          hintStyle: TextStyle(fontWeight: FontWeight.w500),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }
}

class PostSelectInput extends StatelessWidget {
  final String title;
  final String hintText;
  const PostSelectInput({Key key, this.title, this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          TextFormField(
            scrollPadding: const EdgeInsets.symmetric(vertical: 0.0),
            decoration: InputDecoration(
              labelText: '$title *',
              hintText: hintText,
              hintStyle: TextStyle(fontWeight: FontWeight.w500),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              border: UnderlineInputBorder(),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: TextButton(
                  style: TextButton.styleFrom(
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    primary: Colors.black,
                  ),
                  onPressed: () {},
                  child: Container()))
        ],
      ),
    );
  }
  
}
