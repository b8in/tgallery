# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
# ## ## ## ## require_tree .    #FiXME

$(document).ready ->

  $('#refresh-captcha-btn').width($('.simple_captcha').width())
  $(".refresh_image").click ->
    $('div#captcha').load("/pictures/refresh_captcha_div", {flag: true})


# FIXME пока не работает как надо
#  $(window).resize ->
#    x = Math.max(($(window).height() - $('.navbar').height() - 20), $('#page-container').height())
#    $('#page-container').height(x - 20)

$(window).load ->
  page_con_padd_and_margs = parseInt($('#page-container').css('margin-top')) + parseInt($('#page-container').css('margin-bottom'))
  if $('#page-container').height() < ($(window).height() - page_con_padd_and_margs)
    $('#page-container').height($(window).height() - page_con_padd_and_margs)
    carousel_and_pagin_height = $('#carousel').outerHeight(true) + $('.pagination').outerHeight(true) + $('h3').outerHeight(true)
    $('#cetral-image').height($('#page-container').height() - carousel_and_pagin_height)
  else
    $('#page-container').height('100%')
    $('#cetral-image').height('auto')