/**
 * zpath.site - ...creating stuff for others
 * @version v1.03.27
 * @link    http://zetapath.com
 * @author   ()
 * @license 
 */
(function(){var soyjavi;window.soyjavi=soyjavi={version:"1.02.06"},$(function(){return soyjavi.dom={document:$(document),aside:$("aside"),header:$("header"),landing:$("#intro"),text:$("#intro > h1"),more:$("#intro > a")},$(window).stellar(),$("[data-action=aside]").on("click",function(){return soyjavi.dom.aside.toggleClass("active")}),$(document).on("scroll",function(){var percent;return percent=100*soyjavi.dom.document.scrollTop()/soyjavi.dom.landing.height(),percent>1?soyjavi.dom.more.addClass("hide"):soyjavi.dom.more.removeClass("hide"),percent>35?soyjavi.dom.text.addClass("hide"):soyjavi.dom.text.removeClass("hide"),percent>85?soyjavi.dom.header.addClass("fixed"):soyjavi.dom.header.removeClass("fixed")}),$("a[href*=#]:not([href=#])").click(function(){var target;return location.pathname.replace(/^\//,"")===this.pathname.replace(/^\//,"")&&location.hostname===this.hostname&&(target=$(this.hash),target=target.length?target:$("[name="+this.hash.slice(1)+"]"),target.length)?($("html,body").animate({scrollTop:target.offset().top},450),!1):void 0})})}).call(this);