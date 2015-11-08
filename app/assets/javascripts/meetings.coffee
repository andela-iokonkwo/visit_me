# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.multi-select').select2 theme: 'bootstrap'
  $('#add_new_visitor').click ->
    $.fancybox.showLoading()
    setTimeout (->
      $.fancybox
        'transitionIn': 'fade'
        'transitionOut': 'fade'
        'overlayColor': '#000'
        'overlayOpacity': '.6'
        'href': '#new_visitor_form'
        'onCleanup': ->
          return
      return
    ), 500
  return
  $('#new_visitor_form form').submit (e) ->
    alert("submit")
    email = $('#email').val()
    name = $('#name').val()
    emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/
    if email == '' or name == ''
      alert 'Please fill all fields...!!!!!!'
      e.preventDefault()
    else if !email.match(emailReg)
      alert 'Invalid Email...!!!!!!'
      e.preventDefault()
    return
