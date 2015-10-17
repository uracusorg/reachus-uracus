require 'rubygems'
require 'sinatra'
require 'json'

configure do
    set :api_key_mandrill => '9fiCzqrrxM25rh0SEAkxzA',
        :email_mandrill => 'uracus.nlp@gmail.com',
        :tag_mandrill => 'reachus-uracus',
        :subject_message_mandrill => "Uracus contact us form"
    end
require './application'
run Sinatra::Application
