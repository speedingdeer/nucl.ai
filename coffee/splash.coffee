$(window).load ->
  backgroundImage = assets.audienceGif
  $("<img />").attr('src', backgroundImage).load ->
    #render gif when cached
    if $("div.splash-screen-wrap.audience-gif").length > 0
      $("div.splash-screen-wrap").css('background-image', 'url("' + backgroundImage + '")')

$ ->
  $('logo-wrap').addClass("rotated")
  $('logo-wrap').removeClass("opacity0")
  $('titles').removeClass("opacity0")