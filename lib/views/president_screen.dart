import '../utils/export.dart';

class PresidentScreen extends StatefulWidget {
  const PresidentScreen({Key? key}) : super(key: key);

  @override
  _PresidentScreenState createState() => _PresidentScreenState();
}

class _PresidentScreenState extends State<PresidentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Presidente'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PresidentWidget(
              name: 'Bolsonaro',
              photo: 'assets/bolsonaro.png',
              color: Colors.lightGreen,
              onPressed: (){},
            ),
            PresidentWidget(
              name: 'Lula',
              photo: 'assets/lula.png',
              color: Colors.red,
              onPressed: (){},
            ),
            PresidentWidget(
              name: 'Outros',
              photo: 'assets/outro.png',
              color: Colors.blue,
              onPressed: (){},
            )
          ],
        ),
      ),
    );
  }
}
