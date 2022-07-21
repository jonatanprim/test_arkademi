
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Functions{

  getDuration(duration){
    if(duration == 0){
      return 0;
    }
    else{
      return (duration / 60).toInt();
    }
  }

  checkLink(onlineLink, offlineLink){
    if(onlineLink == null || onlineLink == "" && offlineLink == null || offlineLink == ""){
      return false;
    }
    else{
      return true;
    }
  }

  chekOfflineVideo(listVideo,key){
    print("CHECK : $listVideo, $key");
    if(listVideo.length == 0){
      print("NULLLL");
      return false;
    }
    else{
      var flag = 0;
      for(int i = 0 ; i < listVideo.length ; i++){
        if(listVideo[i] == key.toString()){
          flag += 1;
        }
        else{
        }
      }
      print("RESULT : $flag");
      if(flag != 0){
        return true;
      }
      else{
        return false;
      }
    }
  }

}