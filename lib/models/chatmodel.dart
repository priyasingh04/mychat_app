




class ChatMessages {
  String? idFrom;
  String? idTo;
  String? timestamp;
  String? content;


  ChatMessages(
      {required this.idFrom,
        required this.idTo,
        required this.timestamp,
        required this.content,});

  ChatMessages.fromMap(Map<String, dynamic> map){
     idFrom = map['idFrom'];
     idTo = map['idTo'];
     timestamp = map['timestamp'];
     content = map['content'];



  }



    Map<String, dynamic> toMap() {

    return {
     "idFrom": idFrom,
  "idTo": idTo,
      "timestamp": timestamp,
      "content": content,

    };
  }


}