# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

(() -> 
   wow = new WOW({offset: 100, mobile: false})
   wow.init()
   console.log("Sayanora")
)()