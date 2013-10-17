#= require jquery.waterwheelCarousel.min

#old_height = 0

changeCentralImage = ->
  new_url = $('.carousel-center').prop('src').replace(/thumb_/,'')
  $('#cetral-image img').prop('src', new_url)
  arr = new_url.split('/')
  $('#cetral-image a').prop('href', '/categories/'+arr[arr.length-2]+'/'+$('.carousel-center').prop('id'))

  page_con_padd_and_margs = parseInt($('#page-container').css('margin-top')) + parseInt($('#page-container').css('margin-bottom'))
  if $('#page-container').height() < ($(window).height() - page_con_padd_and_margs)
    $('#page-container').height($(window).height() - page_con_padd_and_margs)
    console.log("!")
  else
    $('#page-container').height('100%')
    console.log('?')
  console.log('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

#  new_height = $('#cetral-image').height()
#  $('body').height($('body').height() + (new_height - old_height))
#  console.log old_height + " .. "+ new_height+" .. "+$('body').height()
#  old_height = new_height

$(document).ready ->

  # This initialises carousels on the container elements specified, in this case, carousel1.
  $("#carousel").waterwheelCarousel({startingItem: 3, autoPlay: 5000, movedToCenter: changeCentralImage})
  #old_height = $('#cetral-image').height()