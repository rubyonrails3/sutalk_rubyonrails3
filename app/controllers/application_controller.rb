require 'rubygems'
require 'facebook'

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected

  # Login to facebook if user is not already logged in
  def facebook_login 
    parameters = getParams params 
    logger.debug params
    @fb = Facebook.new parameters 

    if params[:request_ids] 
      @url = "http://www.facebook.com/?sk=wall"
      render :friendRoom, :layout => false
    end 

    if params[:sid]
      session[:session_id] = params[:sid] 
    end 

    if params[:request_ids] && session[:session_id]
      api = Sutalk::Application.config.facebook_api 
      @url = "#{api[:canvas_page]}?sid=#{session[:session_id]}" 
      session[:session_id] = nil
      render :friendRoom, :layout => false
    end

    session[:facebook_id] = @fb::facebook_user["id"] if !@fb::facebook_user.nil? 
        
    if @fb.loggedout?
                # Redirect to facebook login 
      render :facebooklogin, :layout => false
    elsif !User.registered? @fb
      User.register @fb
    end    
  end
  
  # Get Paramters for Facebook Access Token
  def getParams params
    
    if params[:signed_request]
      session[:parameters] = params
    else
      session[:parameters]
    end
  end  
end

