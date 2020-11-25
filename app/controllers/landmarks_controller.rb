require "pry"

class LandmarksController < ApplicationController
  # add controller methods

  get "/landmarks" do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get "/landmarks/new" do
    @figures = Figure.all
    @titles = Title.all
    erb :'/landmarks/new'
  end

  get "/landmarks/:id" do
    @landmark = Landmark.find_by_id(params[:id])
    erb :'/landmarks/show'
  end

  post "/landmarks" do
    @landmark = Landmark.create(params[:landmark])
    redirect to "landmarks/#{@landmark.id}"
  end

  get "/landmarks/:id/edit" do
    @landmark = Landmark.find_by_id(params[:id])
    @titles = Title.all
    @figures = Figure.all

    erb :'/landmarks/edit'
  end

  patch "/landmarks/:id" do
    @landmark = Landmark.find_by_id(params[:id])
    @landmark.update(name: params[:landmark][:name])
    @landmark.update(year_completed: params[:landmark][:year_completed])

    @landmark.save
    redirect to "landmarks/#{@landmark.id}"
  end
end
