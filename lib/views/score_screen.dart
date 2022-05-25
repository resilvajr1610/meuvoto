

import '../utils/export.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {


  int _total = 0;
  int _totalLula = 0;
  int _totalJair = 0;
  int _totalOutro = 0;

  _data()async{

    FirebaseFirestore db = FirebaseFirestore.instance;

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

    _total = _totalOutro + _totalJair + _totalLula;
  }
  @override
  void initState() {
    super.initState();
    _data();
  }

  @override
  Widget build(BuildContext context) {

    List<charts.Series<WishesModel,String>> _seriesBarDataBarra=[];
    List<WishesModel> myData=[];

    _generateGraphiic(myData)async{
      _seriesBarDataBarra.add(
          charts.Series(
            domainFn: (WishesModel wishesModel,_)=>wishesModel.total.toStringAsFixed(0)+' Votos ' + wishesModel.candidate.toUpperCase() +" "+ ((wishesModel.total/_total)*100).toStringAsFixed(1).replaceAll(".", ",")+" %",
            measureFn:(WishesModel wishesModel,_)=>wishesModel.total,
            colorFn: (WishesModel wishesModel,_)=>charts.ColorUtil.fromDartColor(Colors.blue),
            id: 'TotalWishes',
            data: myData,
          )
      );
    }

    Widget _buildBody(context){
      return StreamBuilder<QuerySnapshot>(
          stream:FirebaseFirestore.instance.collection("votos").snapshots(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return LinearProgressIndicator();
            }else{
              List<WishesModel> totais=snapshot.data!.docs.map((documentSnapshot) => WishesModel.fromMap(documentSnapshot.data()as Map<String, dynamic>)).toList();
              myData=totais;
              _generateGraphiic(myData);
              return Container(
                alignment: Alignment.centerLeft,
                child: charts.BarChart(_seriesBarDataBarra,
                  vertical: false,
                  primaryMeasureAxis:new charts.NumericAxisSpec(
                      showAxisLine: false,
                      renderSpec: new charts.NoneRenderSpec()
                  ),
                  barRendererDecorator: new charts.BarLabelDecorator(
                      insideLabelStyleSpec: new charts.TextStyleSpec(color: charts.ColorUtil.fromDartColor(Colors.white),fontSize: 18),
                      outsideLabelStyleSpec: new charts.TextStyleSpec(color: charts.ColorUtil.fromDartColor(Colors.blue),fontSize: 18)
                  ),
                  animate: true,
                  animationDuration: Duration(seconds: 1),
                  domainAxis: charts.OrdinalAxisSpec(
                    renderSpec: charts.GridlineRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        fontSize: 0,
                      ),
                      lineStyle: new charts.LineStyleSpec(color: charts.MaterialPalette.transparent),
                    ),
                    showAxisLine: true,  // doesn't seem to work on it's own - need above 'transparent' line
                  ),
                ),
              );
            }
          }
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Placar'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 80,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage('assets/bolsonaro.png'),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 80,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage('assets/lula.png'),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 80,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage('assets/outro.png'),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 7,
                child: Container(
                  width: double.infinity,
                  height: 350,
                  child: _buildBody(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
