# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

	$("h1.scale").fitText(1, { minFontSize: '26px', maxFontSize: '61px' })
	$("p.scale").fitText(1, { minFontSize: '16px', maxFontSize: '22px' })
	$(".login.scale p").fitText(1, { minFontSize: '16px', maxFontSize: '32px' })
	
	setTimeout ->
		$('.alert').fadeOut('slow')
		$('.alert').parent().parent().hide()
	, 2200