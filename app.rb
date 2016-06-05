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
  #@totalは自分でつけた．
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

post '/delete/:id' do 
  @item = Item.find(params[:id]).destroy
  redirect '/'
end

post '/edit/:id' do
  @item = Item.find(params[:id])
  @categories = Category.all
  erb :edit
end

post '/renew/:id' do 
  @item = Item.find(params[:id])
  @item.update({
    title: @params[:title],
    price: @params[:price],
    category_id: @params[:category]
    })
  redirect '/'
end