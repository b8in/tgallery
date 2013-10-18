#= require jquery.waterwheelCarousel.min

changeCentralImage = ->
  new_url = $('.carousel-center').prop('src').replace(/thumb_/,'')
  $('#cetral-image img').prop('src', new_url)
  arr = new_url.split('/')
  $('#cetral-image a').prop('href', '/categories/'+arr[arr.length-2]+'/'+$('.carousel-center').prop('id'))

  page_con_padd_and_margs = parseInt($('#page-container').css('margin-top')) + parseInt($('#page-container').css('margin-bottom'))
  if $('#page-container').height() < ($(window).height() - page_con_padd_and_margs)
    $('#page-container').height($(window).height() - page_con_padd_and_margs)
    carousel_and_pagin_height = $('#carousel').outerHeight(true) + $('.pagination').outerHeight(true) + $('h3').outerHeight(true)
    $('#cetral-image').height($('#page-container').height() - carousel_and_pagin_height)
  else
    $('#page-container').height('100%')
    $('#cetral-image').height('auto')


$(document).ready ->

  # This initialises carousels on the container elements specified, in this case, carousel.
  $("#carousel").waterwheelCarousel({startingItem: 3, autoPlay: 5000, movedToCenter: changeCentralImage})