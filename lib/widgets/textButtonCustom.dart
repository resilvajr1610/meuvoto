import '../utils/export.dart';

class TextButtonCustom extends StatelessWidget {
  final text;
  final VoidCallback onPressed;
  TextButtonCustom({required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(text,
          style: TextStyle(fontSize: 30),)
    );
  }
}
