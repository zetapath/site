"use strict"

$ ->
  window.zpath =
    document      : $ document
    height        : window.innerHeight or document.documentElement.offsetHeight
    width         : window.innerWidth or document.documentElement.offsetWidth
    aside         : $ "aside"
    header        : $ "header"
    landing       : $ "#intro"
    text          : $ "#intro > h1"
    more          : $ "#intro > a"
    articles      : (id: $(el).attr("id"), px: el.offsetTop for el in $ "article[data-content]")
    maps          : $ ".map > iframe"
    activeArticle : ->
      px = zpath.document.scrollTop()
      px += (zpath.height / 1.75)

      for article, index in zpath.articles when px >= article.px
        unless px >= zpath.articles[index + 1].px #or (index is (zpath.articles.length - 1))
          $("article##{article.id}").addClass("active").siblings().removeClass("active")
          break

  # -- Init UI
  do zpath.activeArticle

  # -- Page scrolling
  $(document).on "scroll", (event) ->
    px = zpath.document.scrollTop()
    percent = (px * 100) / zpath.landing.height()

    if percent > 1
      zpath.more.addClass "hide"
    else
      zpath.more.removeClass "hide"
    if percent > 35
      zpath.text.addClass "hide"
    else
      zpath.text.removeClass "hide"
    if percent > 85
      zpath.header.addClass "fixed"
    else
      zpath.header.removeClass "fixed"
    do zpath.activeArticle

  # -- Smooth Scroll
  $('a[href*=#]:not([href=#])').click ->
    if location.pathname.replace(/^\//, '') == @pathname.replace(/^\//, '') and location.hostname == @hostname
      target = $(@hash)
      target = if target.length then target else $('[name=' + @hash.slice(1) + ']')
      if target.length
        $('html,body').animate scrollTop: target.offset().top, 450
        false

  # -- Mobile Menu
  $("[data-action=aside]").on "click", -> zpath.aside.toggleClass "active"

  # -- Timezones
  window.clock.set "[data-control='clock'][data-timezone='Europe/London']"
  window.clock.set "[data-control='clock'][data-timezone='Asia/Bangkok']"
  $('#location > .container > [data-column]').click (event) ->
    el = $ event.delegateTarget
    timezone = el.children("[data-timezone]").attr "data-timezone"
    zpath.maps.filter("[data-timezone='#{timezone}']")
      .addClass("active")
      .siblings().removeClass("active")
    el.addClass("active").siblings().removeClass("active")
