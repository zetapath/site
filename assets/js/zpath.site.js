/**
 * zpath.site - ...creating stuff for others
 * @version v1.03.27
 * @link    http://zetapath.com
 * @author   ()
 * @license 
 */
(function(){var soyjavi;window.soyjavi=soyjavi={version:"1.02.06"},$(function(){return soyjavi.dom={document:$(document),aside:$("aside"),landing:$(".landing"),text:$(".landing > *:not(.more)"),more:$(".landing > small")},$(window).stellar(),$("[data-action=aside]").on("click",function(){return soyjavi.dom.aside.toggleClass("active")}),$(document).on("scroll",function(){var percent;return percent=100*soyjavi.dom.document.scrollTop()/soyjavi.dom.landing.height(),percent>10?soyjavi.dom.more.addClass("hide"):soyjavi.dom.more.removeClass("hide"),percent>25?soyjavi.dom.text.addClass("hide"):soyjavi.dom.text.removeClass("hide")})})}).call(this);