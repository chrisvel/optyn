module Api
  module V1
    class ShopsController < ApplicationController
      respond_to :json, :except => [:button_framework]
      doorkeeper_for [:create, :clear_session]

      before_filter :fetch_store
      before_filter :log_impression_count, only: [:details]

      skip_before_filter :verify_authenticity_token
      skip_before_filter :fetch_store, :log_impression_count, only: [:create, :clear_session]

      def create
        if params[:name].present? #&& params[:email_frequency].present?
          virtual_shop_domain = params[:name]
          shop = Shop.search_or_add_by_domain(virtual_shop_domain)
          render(json: {data: {name: shop['name']}}, status: :created)
        else
          errors = []
          errors << ["Shop name cannot be blank"] if params[:name].blank?
          #errors << ["Email Frequency needs to be selected"] if params[:email_frequency].blank?
          render(status: :unprocessable_entity, json: {data: {errors: errors.as_json}})
        end
      end

      def button_script
        @application = @shop.oauth_application
        return button_script_content
      end

      def button_framework
        @application = @shop.oauth_application
        call_to_action =  @application.call_to_action.to_i

        if [1, 2].include?(call_to_action)
           return button_framework_script
        elsif 3 == call_to_action
           return email_box_framework_script
        end
      end

      def details
        callback_name = params[:callback]
        response_body = %Q(
        var optynShop = #{@shop.api_welcome_details.to_json}
        #{callback_name}(optynShop);
      )

        render text: response_body
      end

      private
      def fetch_store
        @shop = Shop.by_app_id(params[:app_id].to_s)

        head :unauthorized and false unless @shop.present?
      end

      def log_impression_count
        @shop.increment_impression_count
      end

      def button_script_content
        respond_to do |format|
          script = %Q(
              var outerScript = document.createElement('script');
              outerScript.text =
              "try{" +
                "jQuery();" +
              "}catch(e){" +

                "var js = document.createElement('script');" +

                'js.type = "text/javascript";' +
                'js.src = "//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js";' +

                'document.body.appendChild(js);' +

              '}';
              document.body.appendChild(outerScript);

              setTimeout(function(){
                  #{@application.render_choice.to_i == 1 ? bar : part}

              }, 1000);
          )

          format.any { response.headers['Content-Type'] = "application/javascript"; render text: script }
        end
      end

      def button_framework_script
        respond_to do |format|

          script = %Q(jQuery(document).ready(function(){
                      jQuery.getJSON('#{SiteConfig.app_base_url}#{api_shop_details_path(app_id: params[:app_id], format: :json)}?callback=?', null, function(data){
                        jQuery('#optyn_button_wrapper .optyn-text').html(data.welcome_message);
                        
                        var outerContainer = jQuery('<div />');

                        //Create the first container for button and user count.
                        var firstContainer = jQuery('<div />');
                        firstContainer.attr({id: 'optyn-first-container'});
                        var optynLinkContainer = jQuery('<span />')
                        optynLinkContainer.attr({id: 'optyn-link-container'});
                        var optynLink = jQuery('<a />');
                        optynLink.attr({
                          href: 'javascript:void(0)',
                          id: 'optyn-oauth-link',
                          onClick: 'login()'
                        });


                        var optynImageCb = jQuery('<img />')
                        optynImageCb.attr({
                          src: '#{SiteConfig.app_base_url}/assets/optyn_button_checkbox.png',
                          alt: 'Optyn Logo'
                        });

                        #{"optynLink.append(optynImageCb);" if @application.checkmark_icon}

                        var optynImage = jQuery('<img />')
                        optynImage.attr({
                          src: '#{SiteConfig.app_base_url}/assets/#{@application.call_to_action.to_i == 1 ? 'optyn_button_small.png' : 'optyn_button_large.png'}',
                          alt: 'Optyn Logo'
                        });
                        optynLink.append(optynImage);
                        optynLinkContainer.append(optynLink);
                        firstContainer.append(optynLinkContainer);

                        //var userCountContainer = jQuery('<span />')
                        //userCountContainer.attr({id: 'optyn-user-count-container'});
                        //var userMessageContainer = jQuery('<strong />')
                        //userMessageContainer.append(optynShop.user_count + " " + "user(s) connected");
                        //userCountContainer.append(userMessageContainer);
                        //firstContainer.append(userCountContainer);

                        outerContainer.append(firstContainer);

                        //Create the second container for welcome message
                        var secondContainer = jQuery('<div />');
                        var messageContainer = jQuery('<span />');
                        messageContainer.attr({id: 'optyn-welcome-container'});
                        messageContainer.append(optynShop.welcome_message);
                        secondContainer.append(messageContainer);

                        outerContainer.append(secondContainer);

                        //replace the html of the optyn container
                        jQuery('#optyn-container').html(outerContainer.html());


                      });
                    });

                    var OAUTHURL    =   '#{SiteConfig.app_base_url}#{oauth_authorization_path}?';
                    var VALIDURL    =   '#{SiteConfig.app_base_url}#{oauth_token_path}'; //Show page url
                    var SCOPE       =   'public'; //Need to find out what this is used for?
                    var CLIENTID    =   '#{@shop.app_id}';
                    var CLIENTSECRET =  '#{@shop.secret}'
                    var REDIRECT    =   '#{@shop.redirect_uri}';
                    var TYPE        =   'code';

                    var _url        =   OAUTHURL  + '&client_id=' + CLIENTID + '&redirect_uri=' + REDIRECT + '&response_type=' + TYPE + '&scope=' + SCOPE;
                    //alert(_url);
                    var win = null;

                    function login() {
                      win         =   window.open(_url, "Login - Optyn", 'scrollbars=1, width=600, height=520');

                      var pollTimer   =   window.setInterval(function() {
                          try {
                            domainUrl = win.location.href.split('?')[0];
                            if (domainUrl.match(REDIRECT)) {
                              window.clearInterval(pollTimer);
                              var url =   win.location.toString();
                              acToken = url.split("?")[1].split("=")[1];
                              $(win.document).find('body').html("<h1>Loading....</h1>")
                              //win.close();
                              validateToken(acToken, win);
                            }
                          } catch(e) {
                          }
                      }, 500);
                    }

                    function validateToken(token, win) {
                      param_obj = {'client_id': CLIENTID, 'client_secret': CLIENTSECRET, 'code': token, 'grant_type': 'authorization_code', 'redirect_uri': REDIRECT}
                      jQuery.getJSON((VALIDURL + "?callback=?&" + $.param(param_obj)), function(data){
                        win.location = '#{SiteConfig.app_base_url}#{api_connection_path}?access_token=' + data.access_token;
                        getUserInfo(data.access_token);
                        //win.close();
                      });
                    }

                    function getUserInfo(token) {
                      jQuery.getJSON('#{SiteConfig.app_base_url}#{api_user_profile_path}?callback=?&access_token=' + token, function(user){
                        jQuery('#optyn-first-container').text('Welcome ' + user.name + "!");
                      });
                    }
                  )
          format.any { response.headers['Content-Type'] = "application/javascript"; render text: script }
        end
      end

      def email_box_framework_script
        respond_to do |format|
          script = %Q(jQuery(document).ready(function(){
                        jQuery.getJSON('#{SiteConfig.app_base_url}#{api_shop_details_path(app_id: params[:app_id], format: :json)}?callback=?', null, function(data){

                        jQuery('#optyn_button_wrapper .optyn-text').html(data.welcome_message);
                         
                         var $formContainer = jQuery("<div />");
                         $formContainer.attr({
                           id: 'optyn-first-container'
                         })

                         var $form = jQuery('<form />');
                         $form.attr({
                            id: 'optyn-email-form',
                            action: '#{SiteConfig.app_base_url}#{authenticate_with_email_path}.json?callback=?',
                            method: 'post'
                         });

                         var $emailBox = jQuery('<input />');
                         $emailBox.attr({
                           id: 'user_email',
                           name: 'user[email]',
                           type: 'email',
                           size: '34',
                           placeholder: 'enter your e-mail'
                         });

                         var $submitButton = jQuery('<input />');
                         $submitButton.attr({
                           id: 'commit',
                           name: 'commit',
                           value: 'Subscribe',
                           type: 'submit'
                         });

                          $form.append($emailBox);
                          $form.append($submitButton);
                          $formContainer.append($form)
                          var $temp = jQuery('<div />');
                          $temp.append($formContainer);
                          jQuery('#optyn-container').html($temp.html());
                  });
                });

                var OAUTHURL    =   '#{SiteConfig.app_base_url}#{oauth_authorization_path(format: 'json')}?callback=?';
                var VALIDURL    =   '#{SiteConfig.app_base_url}#{oauth_token_path}'; //Show page url
                var SCOPE       =   'public'; //Need to find out what this is used for?
                var CLIENTID    =   '#{@shop.app_id}';
                var CLIENTSECRET =  '#{@shop.secret}'
                var REDIRECT    =   '#{@shop.redirect_uri}';
                var TYPE        =   'code';

                var _url = OAUTHURL  + '&client_id=' + CLIENTID + '&redirect_uri=' + REDIRECT + '&response_type=' + TYPE + '&scope=' + SCOPE;

                //Call the get authentication method.
                jQuery.getJSON(_url, null, function(data){
                  //DO NOTHING
                });

                //Hook the form submission
                jQuery('body').on('submit', '#optyn-email-form', function(event){
                  event.preventDefault();
                  $.ajax({
                    url: $(this).attr('action'),
                    type: 'GET',
                    data: $(this).serialize(),
                    dataType: 'jsonp',
                    success: function(respJson){
                      if(respJson.data.errors){
                        $('#optyn-first-container').html('<strong>Sorry could not create a connection. Please got to optyn.com and find your favorite shops OR Refresh this page.</strong>');
                      }else{
                        replaceWithUserInfo();
                      }
                    }
                  });
                });

                //fetch the authentication code
                function replaceWithUserInfo(){
                    jQuery.getJSON(_url, null, function(respJson){
                        if(respJson.data.code){
                          validateToken(respJson.data.code);
                        }
                    });
                }

                //fetch the accessToken
                function validateToken(token) {
                      param_obj = {'client_id': CLIENTID, 'client_secret': CLIENTSECRET, 'code': token, 'grant_type': 'authorization_code', 'redirect_uri': REDIRECT}
                      jQuery.getJSON((VALIDURL + "?callback=?&" + $.param(param_obj)), function(data){
                        getUserInfo(data.access_token);
                      });
                }

                //fetch the user info
                function getUserInfo(token) {
                  jQuery.getJSON('#{SiteConfig.app_base_url}#{api_user_profile_path}?callback=?&access_token=' + token, function(user){
                    jQuery('#optyn-first-container').text('Welcome ' + user.name + "!");
                    automaticConnection(token);
                  });
                }


                //Create an automatic connection.
                function automaticConnection(token){
                   jQuery.ajax({
                    url: '#{SiteConfig.app_base_url}#{api_automatic_connection_path}',
                    type: 'POST',
                    data: {'_method': 'put', 'access_token': token}
                   });
                }
            )

          format.any { response.headers['Content-Type'] = "application/javascript"; render text: script }
        end
      end

      def bar
        %Q(
            jQuery('body').prepend(
              '#{style}' +
              '<div id="optyn_button_wrapper">' +
              '<div class="optyn-text">' +
              '</div>' +
              '<div id="optyn-container">' +
              '<h4>Welcome to Optyn</h4>'  +
              '</div>' +
              '<script src="#{SiteConfig.app_base_url}/api/shop/button_framework.js?app_id=#{@application.uid}"></script>' +
              '<div id="close_optyn_button">' +
              '<a href="javascript:void(0)" onclick="hideOptynButtonWrapper(' + "'optyn_button_wrapper', 'show_optyn_button_wrapper')" + '">' +
              '<img src ="http://s11.postimg.org/5i89xyvsf/x_btn.png" /></a>' +
              '</div>' +
              '</div>' +
              '</div>' +
              '<iframe name="optyn-iframe" id="optyn-iframe" style="display:none"></iframe>' +
              '<div id="show_optyn_button_wrapper" style="display:none">' +
              '<a href="javascript:void(0)" onclick="showOptynButtonWrapper(' + "'optyn_button_wrapper', 'show_optyn_button_wrapper')" + '"><img src="http://s23.postimg.org/gm12p8p2f/optyn_button_logo.png" /></a>' +
              '</div>' +
              #{show_hide}
            )
        )
      end

      def part
        %Q(
            var scriptElem = $("script[src='#{SiteConfig.app_base_url}/api/shop/button_script.js?app_id=#{@application.uid}']");
            jQuery(scriptElem).before(
              '<script src="#{SiteConfig.app_base_url}/api/shop/button_framework.js?app_id=#{@application.uid}"></script>' +
              '#{style}' +
              '<div  id="optyn-container">' +
              '<h4>Welcome to Optyn</h4>'  +
              '</div>' +
              '<iframe name="optyn-iframe" id="optyn-iframe" style="display:none"></iframe>'
            )
        )
      end

      def style
        %Q(<style type="text/css"> #optyn_button_wrapper { background-color: #1791c0; margin: 0px; height: 60px; vertical-align: middle; border-bottom:thick solid #046d95; border-width: 2px; } #optyn_button_wrapper .optyn-text { float: left; padding-left: 150px; padding-top: 20px; color: white; font-weight: bold; text-align: center; font-family:"Arial, Verdana", Arial, sans-serif; font-size: 16px; } #optyn_button_wrapper .optyn-button { } #show_optyn_button_wrapper { background-color: #1791c0; background-position: 0 -8px; display: block; height: 40px; /*overflow: hidden;*/ padding: 16px 0 0; position: absolute; right: 20px; top: -3px; width: 80px; z-index: 100; box-shadow: 0 0 5px rgba(0,0,0,0.35); -moz-box-shadow: 0 0 5px rgba(0,0,0,0.35); -webkit-box-shadow: 0 0 5px rgba(0,0,0,0.35); border-bottom-right-radius: 5px; border-bottom-left-radius: 5px; border: 2px solid #046d95; text-align: center; } #close_optyn_button { float: right; font-weight: bold; margin: 0px; padding-right: 30px; padding-top: 20px; color: white; vertical-align: middle; } #close_optyn_button a { color: white; position: absolute; z-index: 100; } #optyn-container { float:left; padding-left: 100px; padding-top: 10px; } #optyn-container form { margin: 0px; } #optyn-container form input[type="submit"] { background: #64b905; border-radius: 4px; display: inline-block; height: 40px; line-height: 38px; top: 4px; color: #ffffff; font size: 18px; text-decoration: none; text-shadow: none; border: 1px #304d58; font-weight: bold; padding-left: 10px; padding-right: 10px; font-size: 14px; } #optyn-container form input:hover[type="Submit"] { background: #80d81c; color: #fff; text-decoration: none; text-shadow: none; } #optyn-container form input[type="email"] { border-color: rgba(1, 59, 81, 0.93); border-style: solid; border-width: 1px; font-size: 16px; height: 38px; padding: 6px; color: white; background-color: #0b6283; margin-right: 10px; font-weight: bold;} #optyn-container h4 { margin: 0px; color: white; } ::-webkit-input-placeholder { /* WebKit browsers */ color: white; } :-moz-placeholder { /* Mozilla Firefox 4 to 18 */ color: white; }::-moz-placeholder { /* Mozilla Firefox 19+ */ color: white; } :-ms-input-placeholder { /* Internet Explorer 10+ */ color: white; } </style>)
      end

      def show_hide
      %Q(
        '<script type="text/javascript">' +
        'function hideOptynButtonWrapper(wrapperId, showLinkId){' +
          'document.getElementById(wrapperId).style.display = "none";' +
          'document.getElementById(showLinkId).style.display = "block";' +
    '}' +

        'function showOptynButtonWrapper(wrapperId, showLinkId){' +
        'document.getElementById(wrapperId).style.display = "block";' +
        'document.getElementById(showLinkId).style.display = "none";' +
    '}' +
    '</script>'
        )
      end
    end
  end
end