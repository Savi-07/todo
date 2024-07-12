import 'package:flutter/material.dart';

class Todoitems extends StatefulWidget {
  final String text;
  final VoidCallback onDelete;

  const Todoitems({Key? key, required this.text, required this.onDelete})
      : super(key: key);

  @override
  _TodoitemsState createState() => _TodoitemsState();
}

class _TodoitemsState extends State<Todoitems> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: () {
          setState(() {
            _isChecked = !_isChecked;
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: Icon(
          _isChecked ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.deepPurple,
        ),
        title: Text(
          widget.text,
          style: TextStyle(
            decoration:
                _isChecked ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: IconButton(
            onPressed: widget.onDelete,
            icon: Icon(Icons.delete),
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
