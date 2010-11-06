# encoding: utf-8
%w(haml rack-flash).each {|gem| require gem}
%w(brameczka url_for config_file).each {|lib| require_relative "lib/#{lib}"}

class SinSMS < Sinatra::Base

  set :environment, (ENV['RACK_ENV'] || 'development')
  set :public, File.dirname(__FILE__) + '/public'

  enable :sessions
  use Rack::Flash
  helpers Sinatra::UrlForHelper
  register Sinatra::ConfigFile

  config_file "credentials.yml"

  use Rack::Auth::Basic do |username, password|
    [username, password] == [SinSMS.auth_user, SinSMS.auth_password]
  end

  get '/' do
    haml :main_page
  end

  post '/send' do
    begin
      raise InvalidArgumentError if params[:sms][:from].empty? or params[:sms][:message].empty? or !(params[:sms][:number].match(/^[0-9]{9,}$/))

      # Podczas wysyłania ucinana jest litera ó, dziwna sprawa
      message = params[:sms][:message].tr("ó", "o")

      response_hash = Brameczka.sms :number => params[:sms][:number], :from => params[:sms][:from], :message => message

      if response_hash.empty?
        flash[:error] = "Wysyłanie nie powiodło się (nieznany błąd)."
      else
        response_text = "#{response_hash[:status]}. #{response_hash[:count]}."
        case response_hash[:status]
        when /SMS zosta/
          flash[:notice] = response_text
        else
          flash[:error] = response_text
        end
      end
    rescue InvalidArgumentError
      flash[:error] = "Wprowadzono błędne dane."
    ensure
      redirect url_for('/')
    end
  end

end

class InvalidArgumentError < StandardError; end
