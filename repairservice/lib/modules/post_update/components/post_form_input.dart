import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/constants.dart';

class PostFormInput extends StatelessWidget {
  final String title;
  final String hintText;
  final Function(String) onChanged;
  final String initialValue;
  final bool readOnly;
  final TextEditingController controler;
  const PostFormInput({
    Key key,
    this.title,
    this.hintText,
    this.onChanged,
    this.initialValue,
    this.controler,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextFormField(
        onChanged: onChanged,
        //controller: controler,
        readOnly: readOnly,
        initialValue: initialValue,
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

class PostAreaInput extends StatelessWidget {
  final String title;
  final String hintText;
  final Function(String) onChanged;
  final String initialValue;
  final bool readOnly;
  final TextEditingController controler;
  const PostAreaInput({
    Key key,
    this.title,
    this.hintText,
    this.onChanged,
    this.initialValue,
    this.controler,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextFormField(
        onChanged: onChanged,
        //controller: controler,
        initialValue: initialValue,
        readOnly: readOnly,
        keyboardType: TextInputType.multiline,
        minLines: 5,
        maxLines: 20,
        maxLength: 1000,
        scrollPadding: const EdgeInsets.symmetric(vertical: 0.0),
        decoration: InputDecoration(
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
  final TextEditingController controler;
  const PostSelectInput({Key key, this.title, this.hintText, this.controler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          TextFormField(
            controller: controler,
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
