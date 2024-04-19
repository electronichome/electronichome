function toggleClassMenu() {
  myMenu.classList.add("menu--animatable"); 
  if(!myMenu.classList.contains("menu--visible")) {   
    myMenu.classList.add("menu--visible");
    $('body').addClass('no-scroll');
  } else {
    myMenu.classList.remove('menu--visible');
    $('body').removeClass('no-scroll'); 
  } 
}

function OnTransitionEnd() {
  myMenu.classList.remove("menu--animatable");
}

var myMenu = document.querySelector(".menu");
var oppMenu = document.querySelector(".menu-open");
var cloMenu = document.querySelector(".menu-icon.icon-close");
myMenu.addEventListener("transitionend", OnTransitionEnd, false);
oppMenu.addEventListener("click", toggleClassMenu, false);
cloMenu.addEventListener("click", toggleClassMenu, false);

