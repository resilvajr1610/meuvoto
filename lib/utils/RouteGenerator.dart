import 'package:meuvoto/views/score_screen.dart';

import '../utils/export.dart';

class RouteGenerator{
    static Route<dynamic>? generateRoute(RouteSettings settings){

      switch(settings.name){
        case "/" :
          return MaterialPageRoute(
              builder: (_) => HomeScreen()
          );
        case "/president" :
          return MaterialPageRoute(
              builder: (_) => PresidentScreen()
          );
        case "/score" :
          return MaterialPageRoute(
              builder: (_) => ScoreScreen()
          );
        default :
          _erroRota();
      }
    }
    static  Route <dynamic> _erroRota(){
      return MaterialPageRoute(
          builder:(_){
            return Scaffold(
              appBar: AppBar(
                title: Text("Tela em desenvolvimento"),
              ),
              body: Center(
                child: Text("Tela em desenvolvimento"),
              ),
            );
          });
    }
  }