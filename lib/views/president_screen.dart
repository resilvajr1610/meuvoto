import '../utils/export.dart';

class PresidentScreen extends StatefulWidget {
  const PresidentScreen({Key? key}) : super(key: key);

  @override
  _PresidentScreenState createState() => _PresidentScreenState();
}

class _PresidentScreenState extends State<PresidentScreen> {

  int _totalLula = 0;
  int _totalJair = 0;
  int _totalOutro = 0;
  int _total = 0;
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool visibleCandidate=true;
  bool visibleOk=false;

  _data()async{

    DocumentSnapshot snapshotLula = await db.collection("votos")
        .doc("lula")
        .get();

    Map<String,dynamic> dadosLula = snapshotLula.data() as Map<String, dynamic>;

    _totalLula = dadosLula["total"]??0;

    DocumentSnapshot snapshotJair = await db.collection("votos")
        .doc("jair")
        .get();

    Map<String,dynamic> dadosJair = snapshotJair.data() as Map<String, dynamic>;

    _totalJair = dadosJair["total"]??0;

    DocumentSnapshot snapshotOutro = await db.collection("votos")
        .doc("outro")
        .get();

    Map<String,dynamic> dadosOutro = snapshotOutro.data() as Map<String, dynamic>;

    _totalOutro = dadosOutro["total"]??0;
  }


  _vote(String candidate){

    switch (candidate){
      case 'jair':
        _total = _totalJair+1;
        break;
      case 'lula':
        _total = _totalLula+1;
        break;
      case 'outro':
        _total = _totalOutro+1;
        break;
    }

    final requisicaoRef = db.collection("votos");
    requisicaoRef.doc(candidate)
        .set({
      "total"     : _total,
      "candidato" : candidate,
    }).then((_){
      setState(() {
        _total=0;
        visibleOk=true;
        visibleCandidate=false;
      });
    });
    print("total votos $candidate : $_total");
  }

  @override
  void initState() {
    super.initState();
    _data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Presidente'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: visibleOk,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 20),
                            child: Text('Voto confirmado',style: TextStyle(color: Colors.green,fontSize: 20)),
                          ),
                          Icon(Icons.check_circle,color: Colors.green),
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: ()=> Navigator.pushReplacementNamed(context, '/score'),
                          child: Text('ok'))
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: visibleCandidate,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PresidentWidget(
                      name: 'Bolsonaro',
                      photo: 'assets/bolsonaro.png',
                      color: Colors.lightGreen,
                      onPressed: ()=>_vote('jair'),
                    ),
                    PresidentWidget(
                      name: 'Lula',
                      photo: 'assets/lula.png',
                      color: Colors.red,
                      onPressed:()=>_vote('lula'),
                    ),
                    PresidentWidget(
                      name: 'Outros',
                      photo: 'assets/outro.png',
                      color: Colors.blue,
                      onPressed: ()=>_vote('outro'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
