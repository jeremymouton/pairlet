# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$(".pixelate h1").fitText(1, { minFontSize: '22px', maxFontSize: '80px' })
	$(".pixelate p").fitText(1, { minFontSize: '16px', maxFontSize: '22px' })