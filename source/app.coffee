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
    contact       : $ "form"
    activeArticle : ->
      px = zpath.document.scrollTop()
      px += (zpath.height / 1.75)
      for article, index in zpath.articles when px >= article.px
        unless px >= zpath.articles[index + 1]?.px
          $("article##{article.id}").addClass("active").siblings().removeClass("active")
          break

  # -- Init UI
  do zpath.activeArticle

  # -- Actions
  $('[data-action]').click (event) ->
    event.preventDefault()
    event.stopPropagation()
  $('[data-action=contact]').click (event) ->
    zpath.contact.toggleClass "active"
  $('[data-action=send]').click (event) ->
    correct = true
    data = {}
    for el in zpath.contact.find("[name]")
      el = $ el
      if el.val().trim() is ""
        correct = false
        break
      data[el.attr("name")] = el.val()

    if correct
      console.log data
      $.ajax
        type      : "POST"
        url       : "http://188.166.53.183:1337/mail"
        data      : data
        dataType  : "json"
        success: (data, status, XHR) =>
          console.log data, status
          alert "We've you!"
          zpath.contact.toggleClass "active"
    else
      alert "Please, fill out the entire form."

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
