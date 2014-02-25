var openedInfoWindow = null;

function initializeMaps(user) {

  $('.search').on("submit", function(e) {
    e.preventDefault();

    gcode($('#location').val(), user);

    // $.post(
    //   "/users/" + user + "/search/create",
    //   {location: geocode($('#location').val())})
    //   .done(function(response){
    //     console.log(response)
    //   })
  })
}

function searchResults(location) {

  // var myLatLng = new google.maps.LatLng(lat, lng)
  // var mapOptions = {
  //   zoom: 10,
  //   center: myLatLng
  // }

  // var map = new google.maps.Map(document.getElementById('map'), mapOptions);

  // for(var i=0; i<places.length; i++) {
  //   addMarker(places[i], map);
  // }

  gcode(location);
}

function gcode(location, user) {
  var geocoder = new google.maps.Geocoder();

  geocoder.geocode({"address": location}, function(results, status){
    createSearch(results[0].geometry.location, user);
  });
}

function createSearch(location, user){
  $.ajax({ 
      url: "/users/" + user + "/search/create",
      type: 'POST',
      data: "info=" + location + $('#radius').val(),
      success: function(response) {
        $('#someDiv').html(response);
      }
    });

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


