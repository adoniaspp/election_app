class Candidate {
  int iD;
  String name;
  int votes;

  Candidate({this.iD, this.name, this.votes});

  Candidate.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    votes = json['Votes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['Votes'] = this.votes;
    return data;
  }

}
