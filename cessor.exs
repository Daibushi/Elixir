#Programa seletor de recebíveis
#@Author Jaderson Nascimento
#@Data 19/12/2016
#Version 1.0

	#Primeira versão totalmente funcional
	#Sistema de parcelas descrito
	#Próxima versão - consertar Process.cessor_gw_out
	#Implementar recursividade

#Valor para efetuar cessão
cessor_value = 700000
#Acumulador de valor cedido
cedido = 0
#Acumulador de recebíveis
receb_cedidos = []

#Load do módulo banco de dados onde estão disponíveis
#os recebíveis a ser selecionados
Code.load_file("banch.exs","./")
	fixed_list = Banch.load()

#Módulo principal 
defmodule Cessor do
	@moduledoc """
	Função direcionadora 
	##parameters

	- list -> lista em forma de matriz
				   [[identificador, preço, numero total de parcelas],[...]]

	- parcel -> número total de parcelas
	- total  -> total a ser cedido durante a execução do programa
	- cedido -> valor cedido atualmente

	##Example 

	[[9999,6622,2],[9998,3119,9],[9997,7941,10],[9996,9610,11]]

	@return -> retorna uma tupla onde o primeiro valor é uma matriz dos
				recebíveis cedidos e o segundo o valor total cedido
		{[[identificador, preço, numero total de parcelas],[...]], valor total cedido}
		
	##Example 

		{[60,97,14,47,67,56,44,22,83,94,49,69,42],9777}

	"""
	def give_way(list,parcel,total,cedido) do
		
		#ordenar pelas parcelas pela terceira coluna
		list = Enum.sort_by(list,fn([_id,_a,b]) -> b end)

	 	#inverter para que as maiores parcelas sejam primeiro
	 	list = Enum.reverse(list)

	 	#selecionar o inicio do slice
	 	start = def_start(list,parcel)

	 	#selecionar quantidade a fatiar
	 	count = def_qtd(list,parcel)

	 	#lista dividida pela quantidade de elementos da determinada parcela
	 	#ordenada pela primeira segunda coluna
	 	sliced_list = Enum.sort_by(slice_parcels(list,start,count),fn([_id,a,_b]) -> a end)
	 	
	 	#iniciar função de cessão após ordenação e separação das parcelas
	 	end_give_way(sliced_list,total,0,[],cedido,true)
	end

	#define onde começa a seção com as determinadas parcelas
	defp def_start(list,parcel) do
		Enum.find_index(list,fn([_id,_a,b]) -> b === parcel end)
	end

	#define quantos elementos devem ser retirados
	defp def_qtd(list, parcel) do
		Enum.count(list,fn([_id,_a,b])-> b === parcel end)
	end

	#retira os elementos de acordo com a parcela
	defp slice_parcels(list,start,count) do
		Enum.slice(list,start,count)
	end

	#Cede começando pelos menores
	 defp end_give_way(_list,_total,_n,temp,acc,verifier) when verifier === false do
  		{temp,acc}	 		
 	 end

  defp end_give_way(list,total, n,temp,acc,verifier) do
    	price = Enum.at(Enum.at(list,n),1)

    	if acc + price < total do
    		acc = price + acc
    		temp = [Enum.at(list,n)|temp]
    	else 
    		verifier = false
    	end 
    end_give_way(list,total, n+1,temp,acc,verifier)
  end
end



# @TODO muitos erros ---- pensar mais


#defmodule Process do 
#	def cessor_gw_out(parcels,n,size,list,cessor,cedido) when n >= size do
#		IO.puts n
#
#	end
#
#	def cessor_gw_out(parcels,n,size,list,cessor,cedido) do
#		
#		receb_cedidos = []
#		parcel = Enum.at(parcels,n)
#		IO.puts parcel
#		IO.puts "#{Enum.at(list,0)} #{parcel} #{cessor} #{cedido} "
#		giveaway = Cessor.give_way(list,parcel,cessor,cedido)
#		
#		IO.puts "elem giveaway"
#
#		cessor_gw_out(parcels,n+1,size,list,cessor,cedido)
#	end
#end

#Process.cessor_gw_out(parcel,0,12,fixed_list,cessor_value,cedido)


IO.puts "~~~~~~~~~~~~~Seletor e processador de recebíveis ~~~~~~~~~~~~~"
		
	giveaway = Cessor.give_way(fixed_list, 7,cessor_value,cedido)

	cedido = elem(giveaway,1)
	receb_cedidos = elem(giveaway,0)

	giveaway = Cessor.give_way(fixed_list,8,cessor_value,cedido)

	if !Enum.empty?(elem(giveaway,0)) do
		cedido = elem(giveaway,1)
		receb_cedidos = Enum.concat(elem(giveaway,0), receb_cedidos)
	end

	giveaway = Cessor.give_way(fixed_list,9,cessor_value,cedido)

	if !Enum.empty?(elem(giveaway,0)) do
		cedido = elem(giveaway,1)
		receb_cedidos = Enum.concat(elem(giveaway,0), receb_cedidos)
	end

	giveaway = Cessor.give_way(fixed_list,10,cessor_value,cedido)

	if !Enum.empty?(elem(giveaway,0)) do
		cedido = elem(giveaway,1)
		receb_cedidos = Enum.concat(elem(giveaway,0), receb_cedidos)
	end

	giveaway = Cessor.give_way(fixed_list,11,cessor_value,cedido)

	if !Enum.empty?(elem(giveaway,0)) do
		cedido = elem(giveaway,1)
		receb_cedidos = Enum.concat(elem(giveaway,0), receb_cedidos)
	end

	giveaway = Cessor.give_way(fixed_list,12,cessor_value,cedido)

	if !Enum.empty?(elem(giveaway,0)) do
		cedido = elem(giveaway,1)
		receb_cedidos = Enum.concat(elem(giveaway,0), receb_cedidos)
	end

	giveaway = Cessor.give_way(fixed_list,6,cessor_value,cedido)

	if !Enum.empty?(elem(giveaway,0)) do
		cedido = elem(giveaway,1)
		receb_cedidos = Enum.concat(elem(giveaway,0), receb_cedidos)
	end

	giveaway = Cessor.give_way(fixed_list,5,cessor_value,cedido)

	if !Enum.empty?(elem(giveaway,0)) do
		cedido = elem(giveaway,1)
		receb_cedidos = Enum.concat(elem(giveaway,0), receb_cedidos)
	end

	giveaway = Cessor.give_way(fixed_list,4,cessor_value,cedido)

	if !Enum.empty?(elem(giveaway,0)) do
		cedido = elem(giveaway,1)
		receb_cedidos = Enum.concat(elem(giveaway,0), receb_cedidos)
	end

	giveaway = Cessor.give_way(fixed_list,3,cessor_value,cedido)

	if !Enum.empty?(elem(giveaway,0)) do
		cedido = elem(giveaway,1)
		receb_cedidos = Enum.concat(elem(giveaway,0), receb_cedidos)
	end

	giveaway = Cessor.give_way(fixed_list,2,cessor_value,cedido)

	if !Enum.empty?(elem(giveaway,0)) do
		cedido = elem(giveaway,1)
		receb_cedidos = Enum.concat(elem(giveaway,0), receb_cedidos)
	end

	giveaway = Cessor.give_way(fixed_list,1,cessor_value,cedido)

	if !Enum.empty?(elem(giveaway,0)) do
		cedido = elem(giveaway,1)
		receb_cedidos = Enum.concat(elem(giveaway,0), receb_cedidos)
	end
	receb_cedidos = Enum.sort(receb_cedidos)

	IO.puts "\n-->Valor máximo cedido : R$ #{cedido}\n"
	

	IO.puts "Recebíveis Cedidos - #{Enum.count(receb_cedidos)}\n===================================================="
	IO.write ("[")
	Enum.each(receb_cedidos, fn([a,_b,_c]) -> IO.write (" #{a},") end)
	IO.write ("]")
	IO.puts "\n============================================================\n\n"
	


