class DataRows {
  List<Rows> rows;

  DataRows({this.rows});

  DataRows.fromJson(Map<String, dynamic> json) {
    if (json['rows'] != null) {
      rows = new List<Rows>();
      json['rows'].forEach((v) {
        rows.add(new Rows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rows != null) {
      data['rows'] = this.rows.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rows {
  String name;
  int rowId;
  Seats seats;

  Rows({this.name, this.rowId, this.seats});

  Rows.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rowId = json['row_id'];
    seats = json['seats'] != null ? new Seats.fromJson(json['seats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['row_id'] = this.rowId;
    if (this.seats != null) {
      data['seats'] = this.seats.toJson();
    }
    return data;
  }
}

class Seats {
  String start;
  String total;
  List<Null> onHold;
  List<String> onHoldSale;
  List<Null> skipSeats;

  Seats({this.start, this.total, this.onHold, this.onHoldSale, this.skipSeats});

  Seats.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    total = json['total'];
    if (json['on_hold'] != null) {
      onHold = new List<Null>();
      json['on_hold'].forEach((v) {
        //onHold.add(new [].fromJson(v));
      });
    }
    onHoldSale = json['on_hold_sale'].cast<String>();
    if (json['skip_seats'] != null) {
      skipSeats = new List<Null>();
      json['skip_seats'].forEach((v) {
        //skipSeats.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['total'] = this.total;
    if (this.onHold != null) {
      //data['on_hold'] = this.onHold.map((v) => v.toJson()).toList();
    }
    data['on_hold_sale'] = this.onHoldSale;
    if (this.skipSeats != null) {
      //data['skip_seats'] = this.skipSeats.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
