/// error : false
/// data : [{"id":"1","image":"uploads/media/2023/image3.jpg","type":"default"}]

class AboutSliderModel {
  AboutSliderModel({
      bool? error, 
      List<Data>? data,}){
    _error = error;
    _data = data;
}

  AboutSliderModel.fromJson(dynamic json) {
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  List<Data>? _data;
AboutSliderModel copyWith({  bool? error,
  List<Data>? data,
}) => AboutSliderModel(  error: error ?? _error,
  data: data ?? _data,
);
  bool? get error => _error;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// image : "uploads/media/2023/image3.jpg"
/// type : "default"

class Data {
  Data({
      String? id, 
      String? image, 
      String? type,}){
    _id = id;
    _image = image;
    _type = type;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _type = json['type'];
  }
  String? _id;
  String? _image;
  String? _type;
Data copyWith({  String? id,
  String? image,
  String? type,
}) => Data(  id: id ?? _id,
  image: image ?? _image,
  type: type ?? _type,
);
  String? get id => _id;
  String? get image => _image;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['type'] = _type;
    return map;
  }

}