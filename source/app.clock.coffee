"use strict"

$ ->
  clock = do ->
    set = (query) ->
      el = $ query
      el =
        sphere  : el
        timezone: moment.tz el.attr "data-timezone"
        seconds : el.find ".seconds"
        minutes : el.find ".minutes"
        hours   : el.find ".hours"
        text    : el.find ".text"

      getTime = ->
        seconds = el.timezone.seconds()
        minutes = el.timezone.minutes()
        hours = el.timezone.hours()
        deg_seconds = seconds * 360 / 60
        deg_minutes = (minutes + seconds / 60) * 360 / 60
        deg_hours = (hours + minutes / 60 + seconds / 60 / 60) * 360 / 12

        el.text.html if hours > 12 then "PM" else "AM"
        el.sphere.attr "class", if hours > 7 and hours < 20 then "" else "night"

        el.seconds.attr 'style', '-webkit-transform: rotate(' + deg_seconds + 'deg); -moz-transform: rotate(' + deg_seconds + 'deg); -ms-transform: rotate(' + deg_seconds + 'deg); -o-transform: rotate(' + deg_seconds + 'deg); transform: rotate(' + deg_seconds + 'deg);'
        el.minutes.attr 'style', '-webkit-transform: rotate(' + deg_minutes + 'deg); -moz-transform: rotate(' + deg_minutes + 'deg); -ms-transform: rotate(' + deg_minutes + 'deg); -o-transform: rotate(' + deg_minutes + 'deg); transform: rotate(' + deg_minutes + 'deg);'
        el.hours.attr 'style', '-webkit-transform: rotate(' + deg_hours + 'deg); -moz-transform: rotate(' + deg_hours + 'deg); -ms-transform: rotate(' + deg_hours + 'deg); -o-transform: rotate(' + deg_hours + 'deg); transform: rotate(' + deg_hours + 'deg);'
        el.timezone.add 1, 'second'

      setInterval getTime, 1000
      getTime()

    set: set

  # -- Timezones
  clock.set "[data-control='clock'][data-timezone='Europe/London']"
  clock.set "[data-control='clock'][data-timezone='Asia/Bangkok']"
  $('#location > .container > [data-column]').click (event) ->
    el = $ event.delegateTarget
    timezone = el.children("[data-timezone]").attr "data-timezone"
    zpath.maps.filter("[data-timezone='#{timezone}']")
      .addClass("active")
      .siblings().removeClass("active")
    el.addClass("active").siblings().removeClass("active")
