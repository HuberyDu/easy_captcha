module EasyCaptcha
  # captcha controller
  class Controller < ActionController::Base
    before_filter :overwrite_cache_control
    # captcha action send the generated image to browser
    def captcha
      if params[:format] == "wav" and EasyCaptcha.espeak?
        send_data generate_speech_captcha, :disposition => 'inline', :type => 'audio/wav'
      else
        send_data generate_captcha, :disposition => 'inline', :type => 'image/png'
      end
    end

    private
    # Overwrite cache control for Samsung Galaxy S3 (remove no-store)
    def overwrite_cache_control
      response.headers["Cache-Control"] = "no-cache, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end
  end
end
