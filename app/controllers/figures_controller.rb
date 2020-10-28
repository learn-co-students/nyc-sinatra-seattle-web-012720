require "pry"

class FiguresController < ApplicationController
  # add controller methods

  get "/figures" do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get "/figures/new" do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  get "/figures/:id" do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

  post "/figures" do
    @figure = Figure.create(params[:figure])
    if !params["title"]["name"].empty? && Title.find_by(name: params["title"]["name"]) == nil
      @figure.titles << Title.create(name: params["title"]["name"])
      @figure.save
    elsif !params["title"]["name"].empty? && Title.find_by(name: params["title"]["name"])
      @figure.titles << Title.find_by(name: params["title"]["name"])
      @figure.save
    elsif !params["landmark"]["name"].empty? && Landmark.find_by(name: params["landmark"]["name"]) == nil
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
      @figure.save
    elsif !params["landmark"]["name"].empty? && Landmark.find_by(name: params["landmark"]["name"])
      @figure.landmarks << Landmark.find_by(name: params["landmark"]["name"])
      @figure.save
    end
    redirect to "figures/#{@figure.id}"
  end

  get "/figures/:id/edit" do
    @figure = Figure.find_by_id(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end

  patch "/figures/:id" do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(name: params[:figure][:name])

    redirect to "figures/#{@figure.id}"
  end
end
