$( document ).ready( function() {
  L.mapbox.accessToken = 'pk.eyJ1IjoibWFuZG9hbWFkb3IiLCJhIjoiY2lmaWFpMDY4Yms2dXNra25meGQ0d2NtdCJ9.bn715gUt-ekH95PaA5CTHw';

  var geocoder = L.mapbox.geocoder('mapbox.places')
  var map = L.mapbox.map('map', 'examples.map-h67hf2ic');
  var API_ENDPOINT = 'http://localhost:3000/listings.json'
  var listings = L.mapbox.featureLayer().addTo(map);

  geocoder.query('Phoenix, AZ', showMap);

  map.attributionControl
      .addAttribution('Places from open door listings');

  $.getJSON(API_ENDPOINT, function(result, status) {
    for (var i = 0; i < result.features.length; i++) {
      var listing = result.features[i];
      var latlng = L.latLng(
        listing.geometry.coordinates[1],
        listing.geometry.coordinates[0]);

      var marker = L.marker(latlng, {
        icon: L.mapbox.marker.icon({
          'marker-color': '#2ba8de',
          'marker-symbol': 'warehouse',
          'marker-size': 'small'
        })
      })
      .bindPopup('<strong>' + listing.properties.street + '</strong>').addTo(listings);
    }
  });

  function showMap(err, data) {
      if (data.lbounds) {
          map.fitBounds(data.lbounds);
      } else if (data.latlng) {
          map.setView([data.latlng[0], data.latlng[1]]);
      }
  }
})
