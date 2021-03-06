import '../utils/export.dart';

class PresidentWidget extends StatelessWidget {
  final name;
  final photo;
  final color;
  final onPressed;

  PresidentWidget({
    required this.name,
    required this.photo,
    required this.color,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(name,
            style: TextStyle(color: color, fontWeight: FontWeight.bold,fontSize: 20),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            width: 200,
            height: height*0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(photo),
                  fit: BoxFit.fill
              ),
            ),
          ),
          ElevatedButton(
              onPressed: onPressed,
              child: Text('Votar')
          )
        ],
      ),
    );
  }
}
