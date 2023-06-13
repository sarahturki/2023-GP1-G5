import 'package:flutter/material.dart';
class CustomFavorite extends StatefulWidget {
  final String title;
  final Color color;
  const CustomFavorite({super.key,required this.title,required this.color});

  @override
  State<CustomFavorite> createState() => _CustomFavoriteState();
}

class _CustomFavoriteState extends State<CustomFavorite> {
    bool favoriteBool = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 145,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(3, 3),
            color: Colors.grey,
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Text(
            widget.title,
            style: TextStyle(
                color:widget. color ,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10,),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: favoriteBool ? Colors.pink : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                favoriteBool =! favoriteBool;
              });
            },
          ),
         
        ],
      ),
    );
  }
}