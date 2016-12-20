#Programa gerador de recebíveis
#@Author Jaderson Nascimento
#@Data 19/12/2016
#Version 1.0

	#Primeira versão totalmente funcional
	#Sistema de parcelas descrito
	#Próxima versão - consertar Process.cessor_gw_out
	#Implementar recursividade

#total de recebíveis gerados
recebiveis_total = 10000
#mostra os recebíveis que foram gerados na tela
show_io = true
percent1 = 10
percent2 = 80
percent3 = 10


defmodule Generate do
		@moduledoc """
		@params
		-percent -> porcentagem a ser gerada
		-total -> total a ser gerado
		-from -> valor minimo de preço
		-to -> valor máximo de preço
		-list -> lista de acumulo de recebíveis
		-x -> controlador <deve ser enviado 0>
		"""

		def recebiveis(percent, total, from, to, list,x) do
		qtd = defineQtd(total,percent)
		createList(qtd, from, to, 0, list,x) 
	end
	
	#definine a quantidade que de recebíveis a ser criados
	def defineQtd(total,percent) do
		i = (percent/100)*total
		i-1
	end

	#define quantas parcelas
	def defineParcel() do
		:rand.uniform(12)
	end

	#define preço de acordo com os limites
	def definePrice(from, to) do 
		n = :rand.uniform(to)
		if n < from do 
			auxDefinePrice(n,from,to)
		else
			n
		end
	end

	# Auxilia monitorando se a vairiável esta de acordo com o range recebido
	def auxDefinePrice(n,from,to) when n < from do
		:rand.uniform(to)
	end

	#=======================================================
	#Cria a lista de recebíveis a ser retoranada
	def createList(qtd, _from, _to,n,list,x)when qtd < n do
		list
	end

	def createList(qtd, from, to,n,list,x) do
		list =  [createitems(from,to,x) |list]

		createList(qtd, from, to,n+1,list,x+1)
	end
	#cria os itens que serão colocados dentro da lista
	def createitems(from,to,x) do
		[x,definePrice(from,to), defineParcel()]
	end
	#=======================================================

end

	lista = []
	IO.puts "Primeiros recebíveis"
	lista = Generate.recebiveis(percent1,recebiveis_total,50,700,lista,0)
	lista = Generate.recebiveis(percent2,recebiveis_total,701,2000,lista,1000)
	lista = Generate.recebiveis(percent3,recebiveis_total,2001,10000,lista,9000)

	IO.puts "Size #{Enum.count(lista)}" 
	
	if show_io do
		Enum.each(lista, fn([id,a,b]) -> IO.puts("[#{id},#{a},#{b}],")end)
	end
