import '../utils/export.dart';

void main() {
  runApp(
    MaterialApp(
      home:  HomeScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    )
  );
}
