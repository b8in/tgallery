#= require jquery.ui.core.min
#= require jquery.ui.widget.min
#= require jquery.ui.rcarousel.min


$(document).ready ->

# This initialises carousels on the container elements specified, in this case, carousel1.
  $("#carousel").rcarousel({height: 150, width: 150, visible: 5, step: 1, margin: 20, speed: 200, auto: {enabled: true}})