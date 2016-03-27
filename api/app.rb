# coding: utf-8
require 'bundler'
Bundler.require

require './film'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'database.db')

def access
  headers 'Access-Control-Allow-Origin' => 'http://localhost:8000'
end

get '/films' do
  access
  films = Film.order(created_at: :desc).page params['page']

  { films: films,
    pages: films.total_pages,
    page: films.current_page }.to_json
end

get '/film/:id' do
  access
  Film.find(params['id']).to_json
end

post '/films' do
  access
  film = Film.new(params)

  if film.save
    film.to_json
  else
    halt 500
  end
end

put '/film/:id' do
  access
  film = Film.find(params['id'])
  film.update(params)

  if film.save
    film.to_json
  else
    halt 500
  end
end

delete '/film/:id/delete' do
  access
  film = Film.find(params['id'])

  if film.destroy
    { success: 'ok' }.to_json
  else
    halt 500
  end
end
