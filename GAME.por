programa
{
	/* INCLUSÃO DAS BIBLIOTECAS */
	inclua biblioteca Texto --> tx //Biblioteca utilizada para fazer o tratamento dos textos
	inclua biblioteca Arquivos --> bdQuiz //Biblioteca que irá manipular o arquivo txt onde estão armazenadas as palavras e dicas do jogo
	inclua biblioteca Tipos --> tp //Biblioteca que ira realizar a conversão de tipos das variaveis
	inclua biblioteca Util // bilibote para gerar um numero randômico para sortear a pergunta 
	
	funcao inicio()
	{

		//opcao que irá armazenar o tema escolhido pelo usuário
		inteiro opcao
		inteiro quant_acertos = 0
		inteiro quant_erros = 0
		inteiro total_perguntas_respondidas = 0
		cadeia respostas_jogadas[100][3]
		cadeia nome

		escreva("\n\n		NOME DO JOGADOR: ")
		leia(nome)
		faca{

			//VARIAVEIS DO LAÇO DE LEITURA DO ARQUIVO
			inteiro l = 0, c //Utilizado como contadores para definir a posição na linha e coluna da matriz 
			inteiro a = 0, b = 0 //Utilizado como contadores da matriz que armazena os temas
			inteiro posi = 0 //armazena a posição inicial para extrair o texto
			inteiro posicao//armazena a posição da |
			inteiro tot //total de caracteres da linha
			cadeia bdDiretorio = "./quiz.txt"//indica que o arquivo se encontra na mesma pasta do programa
			inteiro bd = bdQuiz.abrir_arquivo(bdDiretorio,bdQuiz.MODO_LEITURA) //Referencia ao arquivo aberto - variavel que iremos utilizar para armazenar o local do arquivo/banco de dados
			cadeia linha //armazena a linha para ser filtrada e depois salva na matriz
			cadeia matriz[100][7] //armazena todo o arquivo txt
			//armazena as respostas para exibir no final do programa
			cadeia temas[10][3] //armazenta os temas do Quiz
			
	
	
			
		
	 		
			/* LAÇO QUE IRA LER O ARQUIVO ATÉ O FINAL, SEPARAR AS PALAVRAS DAS DICAS E ARMAZENAR EM ARRAY E MATRIZ */
			enquanto(nao bdQuiz.fim_arquivo(bd)) {
				linha = bdQuiz.ler_linha(bd) //a variavel que armazena a linha a ser filtrada
				tot = tx.numero_caracteres(linha) //armazena a quantidade total de caracteres
				se (linha != "") { //O programa verifica se a linha não está vazia
					para (c=0;c<7;c++) { //Este laço percorre todas as colunas da matriz
						posicao = tx.posicao_texto("|", linha, posi) //localiza a posição da |
						se (posicao == -1) { //Se a posição da barra for -1, significa que é a ultima palavra, então o programa precisa obter o texto da ultima posição da barra até a posição final da linha
					 		matriz[l][c] = tx.extrair_subtexto(linha, posi, tot)
			
						} senao {
							matriz[l][c] = tx.extrair_subtexto(linha, posi, posicao)
						}
					 	posi = posicao+1 //A posição inicial passa a ser a próxima posição depois da |
					}
					posi = 0 //zera a posição inicial para filtrar a próxima linha
	
	
	
	
					
					/* LAÇO QUE IRA ARMAZENAR OS TEMAS */
					/* Este laço armazena os tema das seguinte maneira na matriz
					   NOME DO TEMA / PRIMEIRA VEZ QUE APARECE / ULTIMA VEZ QUE APARECE
					   Pois quando você for sortear as questões do tema, você deve utilizar essas posições armazenadas
					*/
					se (l == 0 ou matriz[l][1] != matriz[l-1][1] ) { //
						temas[a][0] = matriz[l][1] //armazena o tema
						temas[a][1] = tp.inteiro_para_cadeia (l, 10)	//armazena a primeira vez que o tema aparece		
						a++ //este contador ira definir a posição da linha na matriz dos temas
					} senao {
						temas[a-1][2] = tp.inteiro_para_cadeia (l, 10)
					}
					l++ //este contador ira definir a posição da linha na matriz principal	
				}
			} //fim do laço de leitura do arquivo txt	
			//FECHA O ARQUIVO
			bdQuiz.fechar_arquivo(bd)
					
			
	
			//para imprimir os temas disponíveis
			inteiro i = 0
	
			
			//armazena o tema das perguntas a serem procuradas 
			cadeia tema_aux = ""

			// para armaazenar as respostas do usuário
			inteiro resposta = 0
			
			limpa()
			escreva("\n\n		 		JOGO DE PERGUNTAS")

			
			//imprime os temas disponíveis
			escreva(" - PARA FINALIZAR DIGITE 0 \n\n\n\n")
			enquanto(i < a) {
				escreva("		 | [", i+1, "] ")
				escreva(temas[i][0])
				se((i+1)%3==0)
					escreva(" |\n\n")
				senao 
					escreva(" |")

				i = i + 1
			}
			

			escreva("\n\n		  ESCOLHA UM TEMA: ")
			leia(opcao)

			limpa()

			//armazena a quantidade de perguntas já respondidas
			inteiro quant_perguntas_respondidas = 0

			//se o usuário escolheu algum dos temas
			se (opcao > 0 e opcao <= a){	
				
				//armazena a posição do tema escolhido pelo usuário
				inteiro posicao_tema = (opcao - 1)

				escreva("\n				",temas[posicao_tema][0])
				inteiro quant_perguntas = 0

		
				escreva(" \n\n		 NÚMERO DE PERGUNTAS: ")
				leia(quant_perguntas)
				limpa()



				//armazena as perguntas já respondidas com no máximo até 30 perguntas para cada tema
				inteiro perguntas[30]

			
	
				//inicializa as posições do vetor de perguntas já respondidas com -1
				para (inteiro y=0; y<quant_perguntas; y++){
					perguntas[y] = -1
				}
	
			
				//armazena se a perguntar já foi selecionada
				inteiro selecionada = 0 
			
	
				//sorteia 5 perguntas para de acordo com o tema
				para (inteiro k=1; k<=quant_perguntas; k++){
	
					escreva("\n			Pergunta " , k, " - ")
	
	
					//guarda a posição da pergunta sorteada de acordo com tema
					inteiro pergunta_sorteada = 0
	
	
			
					inteiro pode_sair = 0
					faca{			
						//sorteia uma pergunta de acordo com tema escolhido pelo usuário 
						//sortei uma pergunta entre a primeira e ultima vez que o tema aparecer no arquivo
						pergunta_sorteada = Util.sorteia(tp.cadeia_para_inteiro(temas[posicao_tema][1], 10), tp.cadeia_para_inteiro(temas[posicao_tema][2],10))
						selecionada = 0
						para (inteiro p=0; p<=quant_perguntas_respondidas; p++){
							//verifica se a pergunta já foi selecionada, caso sim seleciona uma outra nova
							se(pergunta_sorteada == perguntas[p]){
								selecionada = 1
							}
						}
						se(selecionada == 0){
						
							//armazena a posição da pergunta que já foi respondida para não repetir
							perguntas[quant_perguntas_respondidas] = pergunta_sorteada
							//aumenta uma unidade no contador de perguntas já respondidas
							quant_perguntas_respondidas++
							pode_sair = 1
						}	
					}enquanto(pode_sair == 0)
			
	
					//imprime a pergunta sorteada e captura a resposta do usuário
					faca{
						para (inteiro z=0;z<7;z++) {
							se(z==0){
	    							escreva(matriz[pergunta_sorteada][z])
	    							escreva("\n")
							}
							senao se(z > 2){
								escreva("\n 			ALTERNATIVA ", z - 2, ": ")
								escreva(matriz[pergunta_sorteada][z])
							}
						}
						escreva("\n\n			DIGITE A ALTERNATIVA: ")
						leia(resposta)		
						se(resposta < 1 ou resposta > 4){
							escreva("\n\n			Resposta inválida, digite uma alterntiva entre 1 e 4.\n\n")
						}
					}enquanto(resposta < 1 ou resposta > 4)

					

					//captura a resposta certa do arquivo
					inteiro resposta_certa = tp.cadeia_para_inteiro(matriz[pergunta_sorteada][2],10)
					
					//compara com a resposta certa armazenada no arquivo					
					se(resposta == resposta_certa){
						escreva("\n			RESPOSTA CERTA!\n")
						quant_acertos++
					}
					senao{
						escreva("\n			RESPOSTA ERRADA!\n")
						quant_erros++
					}

					escreva("\n\n			PRÓXIMA PERGUNTA, PRESSIONE ENTER....")
					cadeia enter
					leia(enter)
					limpa()
					//armazena as respostas dada pelo usuário para exibir no final
					respostas_jogadas[total_perguntas_respondidas][0] = matriz[pergunta_sorteada][0]
					respostas_jogadas[total_perguntas_respondidas][1] = matriz[pergunta_sorteada][resposta + 2]
					respostas_jogadas[total_perguntas_respondidas][2] = matriz[pergunta_sorteada][tp.cadeia_para_inteiro(matriz[pergunta_sorteada][2],10) + 2]		
					total_perguntas_respondidas++
					escreva("\n")
					
				}
			}

			se(opcao > a ou opcao < 0){
				escreva("\n\n			Opção inválida!\n\n")
			}
		}enquanto(opcao != 0)
		escreva("\n\n				PARABÉNS VOCÊ CONCLUIU O JOGO!\n\n")
		escreva("\n			JOGADOR: ", nome, "\n\n\n")
		escreva("			TOTAL DE PERGUNTAS RESPONDIDAS: ", total_perguntas_respondidas, " | CERTAS : ", quant_acertos, " | ERRADAS : ", quant_erros)
		para(inteiro m=0;m<total_perguntas_respondidas;m++){
			se(respostas_jogadas[m][1] == respostas_jogadas[m][2]){
				escreva("\n			______________________________________________")
				escreva("\n\n				RESPOSTA CERTA\n")
				
			}
			senao{
				escreva("\n			______________________________________________")
				escreva("\n\n				RESPOSTA ERRADA\n")
			}
			escreva("\n			PERGUNTA: ", respostas_jogadas[m][0])
			escreva("\n			RESPONDIDO: ", respostas_jogadas[m][1])
			escreva("\n			RESPOSTA CORRETA: ", respostas_jogadas[m][2])
			
		}
		escreva("\n\n")
	}
		
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 7774; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */