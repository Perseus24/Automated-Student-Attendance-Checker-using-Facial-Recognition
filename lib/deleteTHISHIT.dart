class Sample{
  String? a;
  String? b;

  Sample({this.a, this.b});

  factory Sample.fromJson(Map<String, dynamic> json){
    return Sample(
      a: json['a'],
      b: json['b']
    );
  }
}