$(document).ready(function () {
    $(window).scroll(function(){
        // add navbar opacity on scroll
        if ($(this).scrollTop() > 100) {
            $(".navbar.navbar-fixed-top").addClass("scroll");
        } else {
            $(".navbar.navbar-fixed-top").removeClass("scroll");
        }

        // global scroll to top button
        if ($(this).scrollTop() > 300) {
            $('.scrolltop').fadeIn();
        } else {
            $('.scrolltop').fadeOut();
        }        
    });

    $('#myCarousel').carousel('cycle');

    // scroll back to top btn
    $('.scrolltop').click(function(){
        $("html, body").animate({ scrollTop: 0 }, 700);
        return false;
    });
    
    // scroll navigation functionality
    $('.scroller').click(function(){
    	var section = $($(this).data("section"));
    	var top = section.offset().top;
        $("html, body").animate({ scrollTop: top }, 700);
        return false;
    });

    // FAQs
    var $faqs = $("#faq .faq");
    $faqs.click(function () {
        var $answer = $(this).find(".answer");
        $answer.slideToggle('fast');
    });

    if (!$.support.leadingWhitespace) {
        //IE7 and 8 stuff
        $("body").addClass("old-ie");
    }
});


$( function() {
    // Code for responsive design for Launchrock theme.
    $( '#dashboard' ).css( 'overflow', 'scroll' );
    $( '.leftNav' ).css( 'overflow', 'scroll' );
    $( '.leftNav' ).css( 'position', 'fixed' );
    $( '.span8' ).addClass( 'offset4' );
    function setDashboardHt() {
        var height = $( window ).innerHeight() - parseInt( $( '.navbar' ).css( 'height' )) - 20;
        $( '#dashboard' ).css( 'height', height );
        $( '.leftNav' ).css( 'height', height );
    }
    setDashboardHt();
    $( window ).resize( setDashboardHt );
});
