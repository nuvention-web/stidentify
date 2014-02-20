var openedInfoWindow = null;

function searchResults(places, lat, lng) {

  var myLatLng = new google.maps.LatLng(lat, lng)
  var mapOptions = {
    zoom: 10,
    center: myLatLng
  }

  var map = new google.maps.Map(document.getElementById('map'), mapOptions);

  console.log(places);

  for(var i=0; i<places.length; i++) {
    addMarker(places[i], map);
  }
}

function addMarker(place, map){
  var reference = place["reference"]

  var latLng = new google.maps.LatLng(place["geometry"]["location"]["lat"], place["geometry"]["location"]["lng"])


  var marker = new google.maps.Marker({
      position: latLng,
      map: map,
      title: place["name"]
  });

  var contentString = "<p><strong>name:</strong> " + place["name"] + "</p>" +
                      "<p><strong>address:</strong> " + place["vicinity"] + "</p>"

  var infoWindow = new google.maps.InfoWindow({
        content: contentString
  });

  google.maps.event.addListener(marker, 'click', function (){
    if (openedInfoWindow != null) openedInfoWindow.close();
    infoWindow.open(map,marker);
    openedInfoWindow = infoWindow;
  });

}


