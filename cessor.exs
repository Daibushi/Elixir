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

parcel = [7,8,9,10,11,12,6,5,4,3,2,1]

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


defmodule Process do 
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

	def cessor_gw_out(_parcels,n,size,_list,_cessor,cedido,acc) when n >= size do
		{acc,cedido}
	end

	def cessor_gw_out(parcels,n,size,list,cessor,cedido,acc) do
		
		_receb_cedidos = []
		parcel = Enum.at(parcels,n)

		receb_cedidos = Cessor.give_way(list,parcel,cessor,cedido)
		
		if !Enum.empty?(elem(receb_cedidos,0)) do
			cedido = elem(receb_cedidos,1)
			acc = Enum.concat(elem(receb_cedidos,0), acc)
		end

		cessor_gw_out(parcels,n+1,size,list,cessor,cedido,acc)
	end
end

temp = Process.cessor_gw_out(parcel,0,12,fixed_list,cessor_value,cedido,[])

receb_cedidos = elem(temp,0)
cedido = elem(temp,1)

IO.puts "~~~~~~~~~~~~~Seletor e processador de recebíveis ~~~~~~~~~~~~~"

	IO.puts "\n-->Valor máximo cedido : R$ #{cedido}\n"
	

	IO.puts "Recebíveis Cedidos - #{Enum.count(receb_cedidos)}\n===================================================="
	IO.write ("[")
	Enum.each(receb_cedidos, fn([a,_b,_c]) -> IO.write (" #{a},") end)
	IO.write ("]")
	IO.puts "\n============================================================\n\n"
#	
#
#
#