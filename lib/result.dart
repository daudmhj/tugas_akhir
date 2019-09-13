class Result {
  final String id;
  final String name;
  final String date;
  final double mean;
  final double sdnn;
  final double sdsd;
  final double rmssd;
  final double pnn20;
  final double pnn50;
  final double lf;
  final double hf;
  final double lfhf;
  final String file;
  final String image;
  final String classification;

  Result._({this.id, this.name, this.date, this.mean, this.sdnn, this.sdsd, this.rmssd, this.pnn20, this.pnn50, this.lf, this.hf, this.lfhf, this.file, this.image, this.classification});

  factory Result.fromJson(Map<String, dynamic> json) {
    return new Result._(
      id: json['id'] as String,
      name: json['name'] as String,
      date: json['date'] as String,
      mean: json['mean'] as double,
      sdnn: json['sdnn'] as double,
      sdsd: json['sdsd'] as double,
      rmssd: json['rmssd'] as double,
      pnn20: json['pnn20'] as double,
      pnn50: json['pnn50'] as double,
      lf: json['lf'] as double,
      hf: json['hf'] as double,
      lfhf: json['lfhf'] as double,
      file: json['file'] as String,
      image: json['image'] as String,
      classification: json['classification'] as String,
    );
  }
}