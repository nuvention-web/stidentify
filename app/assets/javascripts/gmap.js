function searchResults(places, lat, lng) {

  var myLatLng = new google.maps.LatLng(lat, lng)
  var mapOptions = {
    zoom: 10,
    center: myLatLng
  }

  var map = new google.maps.Map(document.getElementById('map'), mapOptions);

  console.log(map);

  for(var i=0; i<places.length; i++) {
    addMarker(places[i], map);
  }
}

function addMarker(place, map){
  var latLng = new google.maps.LatLng(place["geometry"]["location"]["lat"], place["geometry"]["location"]["lng"])


  var marker = new google.maps.Marker({
      position: latLng,
      map: map,
      title: place["name"]
  });

}

function createMap(latlng) {

  



  console.log(data);

  // var myLatlng = new google.maps.LatLng(latlng["lat"], latlng["lng"]);

  // var mapOptions = {
  //   zoom: 13,
  //   center: myLatlng
  // }
  // var map = new google.maps.Map(document.getElementById('map'), mapOptions);

  // var marker = new google.maps.Marker({
  //     position: myLatlng,
  //     map: map,
  //     title: "Learner's location"
  // });
}

