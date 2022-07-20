
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

}