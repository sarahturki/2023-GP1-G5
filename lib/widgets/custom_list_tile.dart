import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  final String title;
  final void Function(bool?)? onChanged;
  final void Function()? onEdit, onDelete;
  final bool value;
  const CustomListTile(
      {super.key,
      required this.title,
      required this.onEdit,
      required this.onDelete,
      required this.onChanged,
      required this.value});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool values = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        // trailing: §,
        trailing: Wrap(
          spacing: 12, // space between two icons
          children: <Widget>[
               IconButton(
              onPressed: widget.onEdit,
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: widget.onDelete,
              icon: const Icon(Icons.delete) ,color:  Color.fromARGB(205, 162, 33, 33),
            ),
         
          ],
        ),

        leading: Checkbox(
          activeColor: Theme.of(context).primaryColor,
          onChanged: widget.onChanged,
          value: widget.value,
          // onChanged:wid
          // value: values,
        ),
        title: Text(
          widget.title,
          style: TextStyle(color: values ? Colors.grey : Colors.black),
        ),
      ),
    );
  }
}
