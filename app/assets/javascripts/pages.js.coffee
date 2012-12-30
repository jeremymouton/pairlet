# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$(".pixelate h1").fitText(1, { minFontSize: '26px', maxFontSize: '62px' })
	$(".pixelate p").fitText(1, { minFontSize: '16px', maxFontSize: '22px' })
	
	setTimeout ->
		$('.alert').fadeOut('slow')
		$('.alert').parent().hide()
	, 2200