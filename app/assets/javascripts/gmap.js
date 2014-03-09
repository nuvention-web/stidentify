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

function searchResults(places) {

  var myLatLng = new google.maps.LatLng(latlng.d, latlng.e)
  var mapOptions = {
    zoom: 13,
    center: myLatLng
  }

  var map = new google.maps.Map(document.getElementById('map'), mapOptions);

  for(var i=0; i < places.length; i++) {
    addMarker(places[i], map, i);
  }
}

function gcode(location, user) {
  var geocoder = new google.maps.Geocoder();

  geocoder.geocode({"address": location}, function(results, status){
    createSearch(results[0].geometry.location, user);
  });
}

function createSearch(location, user){
  latlng = location;

  $.ajax({ 
      url: "/users/" + user + "/search/create",
      type: 'POST',
      data: "info=" + location + $('#radius').val(),
      success: function(response) {
        console.log("THIS WORKS!");
        var results = $.parseJSON(response);
        $('.content-box').html("");
        searchResults(results);
      }
    });

  target = document.querySelector('.load-spin');
  var spinner = new Spinner().spin(target);
  setTimeout(function(){ spinner.stop() }, 4000);
}


function addMarker(place, map, i){
  var reference = place["reference"]

  var latLng = new google.maps.LatLng(place["lat"], place["lng"])

  var marker = new google.maps.Marker({
      position: latLng,
      map: map,
      title: place["name"]
  });

  var website = "<a href='" + place["website"] + "'><button class='button turquoise gmap-button'>Book Now</button></a>"

  /* sidepanel string */
  var contentString1 = "<p id='location_" + i + "'><strong>" + place["name"] + "</strong>"+ "<br/>" + place["address"] + "<br/>" + place["phone"] + "<br/>" + website + "</p>"

  /* infowindow string */
  var contentString2 = "<p id='location_" + i + "'><strong>" + place["name"] + "</strong>"+ "<br/>" + place["address"] + "<br/>" + place["phone"] + "<br/>" + website + place["fees"] + "<br/>" + place["hours"] + "</p>"


  var infoWindow = new google.maps.InfoWindow({
        content: contentString2
  });

  google.maps.event.addListener(marker, 'click', function (){
    if (openedInfoWindow != null) openedInfoWindow.close();
    infoWindow.open(map,marker);
    openedInfoWindow = infoWindow;
    var id = $($.parseHTML(openedInfoWindow.content)[0]).attr('id')
    $(".content-active").toggleClass("content-active");
    $('#' + id).toggleClass("content-active");
  });

  var $info = $(contentString1);

  $info.on("click", function(){
    $(".content-active").toggleClass("content-active");
    $(this).toggleClass("content-active");
    if (openedInfoWindow != null) openedInfoWindow.close();
    infoWindow.open(map,marker);
    openedInfoWindow = infoWindow;
  });

  $('.content-box').append($info);

}


