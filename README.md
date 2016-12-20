# Elixir

Repositório para linguagem elixir


Programa gerador e seletor de recebíveis

-cessor.exs
	Efetua load dos recebíveis no banco e seleciona quais devem ser cedidos para que haja menor perda
	Algoritmo organiza pelas maiores parcelas e cede a partir dos menores preços

	Valores ainda hard-coded

-Generator.exs
	Gera um banco aleatório de recebíveis e os armazena em um arquivo .exs em formato de módulo
	Para fazer load basta efetuar o load do arquivo e chamar a função "Banch.load()" ela retorna 
	uma lista matriz com os recebíveis no padrão listados na documentação interna do "cessor.exs"

-banch.exs
	Banco aleatório gerado pelo "Generator.exs"

-io-padrao.txt
	Padrão de saída do "cessor.exs"
