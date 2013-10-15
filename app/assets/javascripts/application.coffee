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

  if $('#page-container').height() < ($(window).height() - $('.navbar').height() - 20)
    $('#page-container').height($(window).height() - $('.navbar').height() - 20 - 20)

# FIXME пока не работает как надо
#  $(window).resize ->
#    x = Math.max(($(window).height() - $('.navbar').height() - 20), $('#page-container').height())
#    $('#page-container').height(x - 20)
