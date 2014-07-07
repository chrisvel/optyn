
var OP = OP || {};

OP = (function($, window, doucument, Optyn){

  Optyn.StaticPages = {};

  Optyn.StaticPages.initialize = function() {
    if ( $( '#cc-price' ).length ) {
      this.constantContactPricingComparison();
    }
  };

  Optyn.StaticPages.constantContactPricingComparison = function() {
    // Code for Constant Contact pricing section.
    $( '#custom-price' ).keyup( function() {
      if ( $( this ).val() < 0 ) {
        $( '#op-price' ).text( '' );
        return;
      }
      $( '#op-price' ).text( Math.floor( $( this ).val() / 2 ));
    });
    $( '#cc-price' ).change( function() {
      if ( $( this ).val() === 'other' ) {
        $( '.ccc-price' ).val( '' ).slideDown();
        $( '#op-price' ).text( '' );
        return;
      }
      $( '.ccc-price' ).slideUp();
      $( '#op-price' ).text( Math.floor( $( this ).val() / 2 ));
    });
  };

  return Optyn;
})(jQuery, this, this.document, OP);



$(document).ready(function(){
  OP.StaticPages.initialize();
});
