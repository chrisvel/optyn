$(document).ready(function () {
    var file_import = new FileImport();
    file_import.initialize();
});
function FileImport() {
    this.initialize = function () {
        if ($('.import .chzn-select').length) {
            this.hookChosen();
            this.hookAddNewLabel();
            this.hookDisableSubmitTag();
        }
    };

    this.hookChosen = function () {
        $('#label_ids').chosen();
    };

    this.hookAddNewLabel = function () {
        $('body').on('keydown', '.search-field input', function (e) {
            var $input = $(this);
            var code = e.keycode || e.which;
            if (code == 13) {
                var inputVal = $input.val();
                if (inputVal.length) {
                    var $currentLabel = $input.parents('.labels').first();
                    var $currentSelect = $currentLabel.find('select');

                    $.ajax({
                        url: $('#create_label_users_path').val(),
                        type: 'POST',
                        data: {
                            label: inputVal,
                            user_id: $currentLabel.find('.user_id').val()
                        },
                        success: function (data) {
                            $('.chzn-select').append(
                                $('<option></option>')
                                .val(data.name)
                                .html(data.name)
                                );
                            $currentSelect.find('option[value="' + data.name + '"]').attr('selected', 'selected');
                            $('#label_ids').trigger("liszt:updated");
                            if  ($( '.import input[type=file]').val() != '' ){
                                $( 'input[name=commit]' ).tooltip( 'destroy' )
                                .removeAttr( 'disabled' )
                                .removeClass( 'disabled' );

                            }
                        }
                    });
                }
            }
        });
    };

    this.hookDisableSubmitTag = function () {
        if ( $( '.import input[type=file]').val() == '' ) {
            $( 'input[name=commit]' ).addClass( 'disabled' )
            .attr( 'disabled', '' );
        }

        $('.import input[type=file]').change( function() {
            if($('ul.chzn-choices li.search-choice').length == 0){
                $( 'input[name=commit]' ).addClass( 'disabled' )
                .attr( 'disabled', '' );
            }
            else{
                $( 'input[name=commit]' ).tooltip( 'destroy' )
                .removeAttr( 'disabled' )
                .removeClass( 'disabled' );
            }
        });

        $('#label_ids').chosen().change(function(event) {
            var  target = $(event.target);
            currentDataSet = target.val();
            if (currentDataSet === null){
                $( 'input[name=commit]' ).addClass( 'disabled' )
                .attr( 'disabled', '' );
            }
            else if  ($( '.import input[type=file]').val() == '' ){
                $( 'input[name=commit]' ).addClass( 'disabled' )
                .attr( 'disabled', '' );
            }
            else{
                $( 'input[name=commit]' ).tooltip( 'destroy' )
                .removeAttr( 'disabled' )
                .removeClass( 'disabled' );

            }

        });
    };


}
