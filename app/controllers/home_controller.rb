class HomeController < ApplicationController
require 'rest-client'
require 'json'

  def index

  end	
 



  def todo
  	@matriz = []
	if params[:key1] != nil  then
		respuesta = RestClient.get 'https://api.chucknorris.io/jokes/random?category=' + params[:key1]
		respuesta    = JSON.parse(respuesta)
		puts JSON.pretty_generate(respuesta)
		@categoria = params[:key1]
		@matriz[0] = respuesta.fetch("value")
		puts "XXXXX #{@matriz[0]}"
		registro = Chuck.new
		registro.categoria = params[:key1]
		registro.valor = @matriz[0]
		registro.save
	end

	if params[:key2] != nil then
		@categoria = ""
		respuesta = RestClient.get 'https://api.chucknorris.io/jokes/search?query=' + params[:key2]
		respuesta    = JSON.parse(respuesta)
		puts JSON.pretty_generate(respuesta)
		i = respuesta.fetch("total")
		for j in 0..i-1 do
			@matriz[j] = respuesta["result"][j].fetch("value")
			registro = Chuck.new
			registro.categoria = ''
			registro.valor = @matriz[j]
			registro.save
		end	
	end

	puts "XXXXX #{@matriz}"
	render :todo
  end	

end  