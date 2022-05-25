class WishesModel{
  final String candidate;
  final int    total;

  WishesModel(this.candidate,this.total);

  WishesModel.fromMap(Map<String,dynamic>map)
      :assert(map["total"]!=null),
        assert(map["candidato"]!=null),
        total=map["total"],
        candidate=map["candidato"];

  @override
  String toString()=> "Record<$total:$candidate>";
}