require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models/item.rb'
require 'nokogiri'

get '/' do
  @items = Item.all
  @total = Item.sum(:price)
  @categories = Category.all
  erb :index
end

get '/category/:id' do
  @categories = Category.all
  @category = Category.find(params[:id])
  @category_name = @category.name
  @items = @category.items
  @total = @items.sum(:price)
  erb :index
end

post '/create' do

  Item.create({
      title: params[:title],
      price: params[:price],
      category_id: params[:category]
  })
  redirect '/'
end