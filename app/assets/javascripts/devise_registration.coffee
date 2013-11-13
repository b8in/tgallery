#= require jquery.validate

$(document).ready ->

  $("#new_user").validate
    rules:
      "user[name]":
        required: true
      "user[email]":
        required: true,
        email: true
      "user[password]":
        required: true,
        minlength: 4,
        maxlength: 20
      "user[password_confirmation]":
        required: true,
        minlength: 4,
        maxlength: 20,
        equalTo: "#user_password"
      "captcha":
        required: true