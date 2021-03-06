var opTheme = opTheme || {};
$(document).ready(function () {
    // Resize column heights on campaign preview and edit pages.
    if ( $( 'body' ).hasClass( 'merchants-messages' )) {
        if ( $( 'body' ).hasClass( 'edit' ) || $( 'body' ).hasClass( 'preview' )) {
            opTheme.equalizeDivHeights([ '#merchants > .span6:first', '#preview_wrapper' ]);
            $( '#preview_wrapper' ).css( 'background-color', $( '#preview_wrapper td:first' ).css( 'background-color' ));
        }
    }

    $( '.scrolltop' ).html( "<i class='icon-arrow-up icon-white'></i>" );
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


    // Placeholder support for old browsers ....................................
    if ( 'placeholder' in document.createElement( 'input' )) {}
    else {
      $( 'input[type=text]' ).each( function( i, v ) {
        if ( $( this ).attr( 'value' ).length == 0 ) {
            $( v ).attr( 'value', $( v ).attr( 'placeholder' ));
        }
      });
    }


    // Initialise tooltips .....................................................
    var initTooltips = function() {
        $( '[data-toggle=tooltip]' ).each( function( index, value ) {
            var position = $( this ).attr( 'data-tooltip-pos' );
            if ( position == '' ) {
                position = 'top';
            }
            $( this ).tooltip({
                placement: position
            });
        });
    };
    initTooltips();


    // Ensure footer is stuck to bottom of window ..............................
    var setMidContentHt = function( headerSelector, contentSelector, footerSelector ) {
        var headerHt = parseInt( $( headerSelector ).css( 'height' ));
        var footerHt = parseInt( $( footerSelector ).css( 'height' ));
        var windowHt = $( window ).height();
        $( contentSelector ).css( 'min-height', windowHt - headerHt - footerHt );
    };

    // Ensuring footer is stuck to the bottom in application layout ............
    if ( $( 'body' ).hasClass( 'a-layout' )) {
        setMidContentHt( 'header.navbar', '.a-layout .yield', 'footer' );
        $( window ).resize( function() {
            setMidContentHt( 'header.navbar', '.a-layout .yield', 'footer' );
        });
    }

    // Ensuring footer is stuck to the bottom in email_feedback layout .........
    if ( $( 'body' ).hasClass( 'ef-l' )) {
        setMidContentHt( '.navbar', '.ef-l .yield', 'footer' );
        $( window ).resize( function() {
            setMidContentHt( '.navbar', '.ef-l .yield', 'footer' );
        });
    }

    // Setting height of modal .................................................
    var setModalHt = function() {
        $( '.modal-body' ).each( function( index, value ) {
            var modalHeaderHt = parseInt( $( this ).parent().find( '.modal-header' ).css( 'height' ));
            var modalFooterHt = parseInt( $( this ).parent().find( '.modal-footer' ).css( 'height' ));
            $( this ).css( 'max-height', $( window ).height() - modalHeaderHt - modalFooterHt - 80 );
        });
    };
    setModalHt();
    $( window ).resize( setModalHt );

    // Call handleTabLayout() only when there's a h1 and tab pane beside it,
    // like the one on campaign pages.
    if ( $( 'h1' ).css( 'float' ) === 'left' && $( '.tab-pane' ).size())
        handleTabLayout();


    // Dropdown for Features link in static pages header .......................
    $( '#features-dd-toggle' ).mouseenter( function() {
        if ( window.innerWidth < 980 ) return;
        $( '#header-static-features-dropdown' ).fadeIn();
        $( '#header-static-features-dropdown' ).addClass( 'visible' );
        $( this ).addClass( 'current' );
        $( '.dark-overlay' ).fadeIn();
    });
    $( '.dark-overlay, .nav > li:not(#features-dd-toggle)' ).mouseenter( function() {
        if ( window.innerWidth < 980 ) return;
        $( '#header-static-features-dropdown' ).removeClass( 'visible' );
        $( '#features-dd-toggle' ).removeClass( 'current' );
        $( '#header-static-features-dropdown' ).fadeOut();
        $( '.dark-overlay' ).fadeOut();
    });


    if ( $( 'body' ).hasClass( 'edit' ) && $( 'body').hasClass( 'merchants-messages' ) || $( 'body' ).hasClass( 'preview' ) && $( 'body').hasClass( 'merchants-messages' ) ) {
        // Call this function only on edit campaign content page.
        moveFooterPosition();
    }
});


// Handle tabs in various resolutions
function handleTabLayout() {
    var h1Width = parseInt( $( '.yield h1:first' ).css( 'width' ));
    var handleLayout = function() {
        var tabsWidth = 0;
        $( '.yield .tab-pane a' ).each( function( index, value) {
            tabsWidth += parseInt( $( this ).css( 'width' ));
        });
        if ( h1Width + tabsWidth > parseInt( $( '.yield' ).css( 'width' ))) {
            $( 'h1:first' ).css({
                'float': 'none',
                'margin-bottom': '0'
            });
        } else {
            $( 'h1:first' ).css({
                'float': 'left'
            });
        }
    };
    handleLayout();
    $( window ).resize( handleLayout );
}


function moveFooterPosition() {
    $footer = $( 'footer' ).detach();
    $editCampCont = $( '.tear-page > .span6 > .pos-rel' );
    $editCampCont.append( $footer );
    $footer.fadeIn();
    $editCampCont.css( 'padding-bottom', parseInt( $footer.css( 'height' )) + 20 );
}
