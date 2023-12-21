import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModal {
  late String? id;
  late Map<String, dynamic>? user;
     double? rating;
 late  String? date;
late   String? comment;


  ReviewModal( { this.user,   this.rating, this.date,  this.comment, this.id});

ReviewModal.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    id = snapshot.id;
      user = snapshot['user'];
   rating = snapshot['rating'] as double?;
      date = snapshot['date'];
      comment=snapshot['comment'] ;
  
  
 
  }

  ReviewModal.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  user = json['user'];
    rating = json['rating'];
    date = json['date'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
     data ['id'] = this.id;
    data['user'] = this.user;
    data['rating'] = this.rating;
    data['date'] = this.date;
    data['comment'] = this.comment;
    return data;
  }
   Map<String, dynamic> toMap() => {
        'id': id,
        'user': user ,
        'rating' : rating ,
        'date' : date ,
        'comment' : comment,
        

      };
}