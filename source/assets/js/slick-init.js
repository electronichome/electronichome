// Slick
$(document).ready(function() {
  $('.slider-image').slick({
    dots: false,
    arrows: true,
    fade: true,
    infinite: true,
    touchThreshold: 100,
    responsive: [
      {
        breakpoint: 767,
        settings: {
          dots: false
        }
      }
    ]
  });
  $('.photo-slider').css('visibility','visible');
});
