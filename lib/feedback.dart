import 'location.dart';

class myFeedback{
  Location location;
  String description;
  String sentiment;
  String user;
  String pushId;
  String status;
  DateTime timeOfSending;

  static List<sugestedItem> loadSomeSuggestedItems(String areaClass){
    List<sugestedItem> myList = List();
    if(areaClass=="lavatory") {
      myList.add(sugestedItem(text: 'Dirty toilet bowl', isSelected: false));
      myList.add(sugestedItem(text: 'Floor is full of water', isSelected: false));
      myList.add(sugestedItem(text: 'There is no toilet paper', isSelected: false));
    }
    return myList;
  }

}

class sugestedItem{
  String text;
  bool isSelected;

  sugestedItem({this.text, this.isSelected});

  Map<String,dynamic> toJson(){
    return {
      "text": this.text,
      "isSelected": this.isSelected,
    };
  }

}