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
  console.log('@@@@')

  $('#refresh-captcha-btn').width($('.simple_captcha').width())
  $(".refresh_image").click ->
    $('div#captcha').load("/pictures/refresh_captcha_div", {flag: true})
  console.log('zzzzzzzzzzzzzz')



# FIXME пока не работает как надо
#  $(window).resize ->
#    x = Math.max(($(window).height() - $('.navbar').height() - 20), $('#page-container').height())
#    $('#page-container').height(x - 20)

$(window).load ->
  console.log('******')
  console.log $('#page-container').height()
  page_con_padd_and_margs = parseInt($('#page-container').css('margin-top')) + parseInt($('#page-container').css('margin-bottom'))
  console.log page_con_padd_and_margs
  if $('#page-container').height() < ($(window).height() - page_con_padd_and_margs)
    $('#page-container').height($(window).height() - page_con_padd_and_margs)
    console.log('11111')
  else
    $('#page-container').height('100%')
  console.log('++')