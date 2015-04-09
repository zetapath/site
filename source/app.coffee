window.soyjavi = soyjavi = version: "1.02.06"

$ ->
  soyjavi.dom =
    document: $ document
    aside   : $ "aside"
    header  : $ "header"
    landing : $ "#intro"
    text    : $ "#intro > h1"
    more    : $ "#intro > a"

  $(window).stellar()

  $("[data-action=aside]").on "click", ->
    soyjavi.dom.aside.toggleClass "active"


  $(document).on "scroll", (event) ->
    percent = (soyjavi.dom.document.scrollTop() * 100) / soyjavi.dom.landing.height()
    console.log "% #{percent}"
    if percent > 10
      soyjavi.dom.more.addClass "hide"
    else
      soyjavi.dom.more.removeClass "hide"
    if percent > 25
      soyjavi.dom.text.addClass "hide"
    else
      soyjavi.dom.text.removeClass "hide"
    if percent > 80
      soyjavi.dom.header.addClass "fixed"
    else
      soyjavi.dom.header.removeClass "fixed"



  $('a[href*=#]:not([href=#])').click ->
    if location.pathname.replace(/^\//, '') == @pathname.replace(/^\//, '') and location.hostname == @hostname
      target = $(@hash)
      target = if target.length then target else $('[name=' + @hash.slice(1) + ']')
      if target.length
        $('html,body').animate scrollTop: target.offset().top, 450
        false
