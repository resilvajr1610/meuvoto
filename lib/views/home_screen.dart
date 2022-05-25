import '../utils/export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Meu Voto'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButtonCustom(
               text: 'Votar',
               onPressed:()=>Navigator.pushNamed(context, '/president') ,
            ),
            SizedBox(height: 20),
            TextButtonCustom(
              text: 'Placar',
              onPressed:()=>Navigator.pushNamed(context, '/score') ,
            )
          ],
        ),
      ),
    );
  }
}
