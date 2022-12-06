.data
	zero: .float 0.0
	um: .float 1.0
	lim: .float 11.0

	msg_raiz_Q: .asciiz "\nRaiz Quadrada: \n" #declara variavel potencia para achar o valor da sua raiz quadrada: \n'
	msg1: .asciiz "\nInsira o primeiro valor:\n"
	msg2: .asciiz "\nInsira o segundo valor:\n"
	msg3: .asciiz "\nEscolha a opera��o:\n1-Soma\n2-Subtracao\n3-Multiplicacao\n4-Divisao\n5-Potencia\n6-Raiz Quadrada\n7-Tabuada\n-> "
	msg4: .asciiz "\nEscolha uma opera��o da Tabuada:\n1-Soma\n2-Subtracao\n3-Multiplicacao\n4-Divisao\n->"
	
	msgVT: .asciiz "\nInsira o numero para gerar a tabuada: \n"
	msgR: .asciiz "\nRESULTADO: "
	msgI: .asciiz "\n Escolha uma opera��o: \n"
	msgF: .asciiz "\n\nDeseja continuar?\n1-Sim\n2-N�o\n"
	
	nx: .asciiz " X "
	na: .asciiz " + "
	ns: .asciiz " - "
	nd: .asciiz " / "
	i: .asciiz " = " 
	v: .asciiz "\n" # espa�o vazio
.text
	lwc1 $f5, zero	
op:
#-------------------------------------------------------------------------------------------------------#
	li $v0,4     #comando de impress�o de inteiro na tela
	la $a0, msg3 #coloca o texto soma para ser impresso
	syscall      # efetua a chamada ao sistema
	
	li $v0, 5    #le entrada do usu�rio
	syscall      # efetua a chamada ao sistema
	
	move $s2, $v0  # move conte�do de $v0 para $s2
#-------------------------------------------------------------------------------------------------------#
	j main       
#-------------------------------------------------------------------------------------------------------#
main:
	lwc1 $f1, zero
#-------------------------------------------------------------------------------------------------------#	
	beq $s2,1,soma            #verifica se $s2 � igual a 1 se for desvia para soma
	beq $s2,2,subtracao       #verifica se $s2 � igual a 2 se for desvia para subtracao
	beq $s2,3,multiplicacao   #verifica se $s2 � igual a 3 se for desvia para multiplicacao
	beq $s2,4,divisao         #verifica se $s2 � igual a 4 se for desvia para divisao
	beq $s2,5,Potenciacao     #verifica se $s2 � igual a 5 se for desvia para Potenciacao
	beq $s2,6,raiz_quadrada   #verifica se $s2 � igual a 6 se for desvia para Raiz quadrada
	beq $s2,7,tabuada          #verifica se $s2 � igual a 7 se for desvia para Tabela
#-------------------------------------------------------------------------------------------------------#
valor1:	
#--------------------------------------------------------------------------------------------------------#
	li $v0,4     #comando de impress�o de inteiro na tela
	la $a0, msg1 #coloca o texto soma para ser impresso
	syscall      # efetua a chamada ao sistema
	
	li $v0, 6    #le entrada do usu�rio
	syscall      #faz chamada ao sistema
	
	add.s $f3, $f1,$f0 #salva o velor de Fo no F3 por meio da soma do F1 com o F2
	jr $ra             # volta da onde foi chamado
#-------------------------------------------------------------------------------------------------------#
valor2:
#-------------------------------------------------------------------------------------------------------#
	li $v0,4     #comando de impress�o de inteiro na tela
	la $a0, msg2 #coloca o texto soma para ser impresso
	syscall      # efetua a chamada ao sistema
	
	li $v0, 6    #le entrada do usu�rio
	syscall      # efetua a chamada ao sistema
	
	add.s $f4, $f1,$f0 #salva o velor de Fo no F3 por meio da soma do F1 com o F2
	jr $ra             # volta da onde foi chamado
#-------------------------------------------------------------------------------------------------------#
# fun��es
#-------------------------------------------------------------------------------------------------------#	
	soma:		
		jal valor1       #vai para a fun valor 1 e volta
		jal valor2	 #vai para a fun valor 2 e volta
		jal resultado    # vai para a fun��o de imprimir a palavra resultado
		add.s $f12,$f3,$f4  #executa a soma entre os valores 1 e 2
		
		j print             # pula para a fun��o print
	
	subtracao:
		jal valor1        #vai para a fun valor 1 e volta
		jal valor2        #vai para a fun valor 2 e volta
		jal resultado	  # vai para a fun��o de imprimir a palavra resultado	

		sub.s $f12,$f3,$f4  #subtrai os valores dos registradores $F3 e $F4 e insere o resultado no registrador $F12
		j print             # pula para a fun��o print
	
	multiplicacao:
		jal valor1	#vai para a fun valor 1 e volta
		jal valor2	#vai para a fun valor 2 e volta
		jal resultado	# vai para a fun��o de imprimir a palavra resultado
		
		mul.s $f12,$f3,$f4    #multiplica os valores dos registradores $F3 e $F4 e insere o resultado no registrador $F12
		j print            #pula para print
	
	divisao:
		jal valor1	#vai para a fun valor 1 e volta
		jal valor2	#vai para a fun valor 2 e volta
		jal resultado	# vai para a fun��o de imprimir a palavra resultado

		div.s $f12,$f3,$f4    #divide os valores dos registradores $F3 e $F4 e insere o resultado no registrador $F12
		j print            #pula para print
	
	Potenciacao:
		jal valor1	#vai para a fun valor 1 e volta
		jal valor2	#vai para a fun valor 2 e volta
		jal resultado	# vai para a fun��o de imprimir a palavra resultado
		#--------------------# Zerando os registradores f9 e f12 para caso haja outra requisi��o na potencia
		lwc1 $f9, zero
		lwc1 $f12, zero
		#--------------------#
		lwc1 $f7, um                #seta o registrador F7 com o valor 1.0
		add.s $f12, $f1, $f7	    #seta o registrador F12 com 1.0 por meio da soma de F1 e F7
		potencia_loop: 		    
        		mul.s $f12, $f12, $f3    #multiplica��o onde o F12 recebe a multiplica��o de F12 e F3  
	       		add.s $f9, $f9, $f7 	 #contador onde o F9 vai sendo somado 1
	        	c.eq.s $f9, $f4    	 #Condicional de caso o F9 for igual o F4 ele vai para o bc1t print, caso contrario vai para jal potencia_loop
			bc1t print 		 #vai para a fun��o print caso a condicional anterior for true
	       		jal potencia_loop	# volta para a fun��o potencia_loop	
	raiz_quadrada:
		li $v0,4     		#comando de impress�o de inteiro na tela
		la $a0, msg_raiz_Q 	#coloca o texto soma para ser impresso
		syscall      		# efetua a chamada ao sistema
		
		jal valor1 		#vai para a fun valor 1 e volta
		jal resultado		# vai para a fun��o de imprimir a palavra resultado
	
		sqrt.s $f12,$f3		#raiz quadrada os valores dos registradores $F3 e $F4 e insere o resultado no registrador $F12
		j print	     		#pula para print
	tabuada:
		#--------------------# ZERA $t3
		move $t3, $zero
		#--------------------#
		#--------------------# Zerando os registradores f9 e f12 para caso haja outra requisi��o na potencia
		lwc1 $f9, zero
		lwc1 $f12, zero
		#--------------------#
	#----------------------------------------------------# Escolha da ope��o da tabuada
		li $v0, 4
    		la $a0, msg4  #print da mensagem 
    		syscall
    		
    		li $v0, 5    #leu o valor da op
		syscall 
		move $t1,$v0
	#----------------------------------------------------#	
		beq $t1,4,z   #caso div
	#----------------------------------------------------#	Valor que quer gerar a tabuada	
		li $v0, 4
    		la $a0, msgVT  #print da mensagem 
    		syscall
    		
    		li $v0, 5    #leitura o valor para criar a tabela 
		syscall 
		move $t2,$v0
	#----------------------------------------------------#	
		j conta 	# pula para a fun��o conta
		
		opdtA: 				#fun��o de soma da tabela
			add $t5,$t2,$t3
			j print_t		# pula para a fun��o print_t
		opdtS: 				#fun��o de subtra��o da tabela
			sub $t5,$t3,$t2
			j print_t2		# pula para a fun��o print_t2
		opdtM: 				#fun��o de multiplica��o da tabela
			mul $t5,$t2,$t3
			j print_t		# pula para a fun��o print_t
		opdtD: 				#fun��o de divis�o da tabela
			div.s $f12,$f3,$f9
			j printd		# pula para a fun��o print_d
		
		x:
			li $v0, 4
    			la $a0, nx  #print da X
    			syscall
    			j print_t3
    		a:
    			li $v0, 4
    			la $a0, na  #print da +
    			syscall
    			j print_t3
    		s:
    			li $v0, 4
    			la $a0, ns  #print da -
    			syscall
    			j print_t4		
		conta:
			addi $t3, $t3, 1
			beq $t3 , 11, volta
			#--------------------#
			beq $t1,1,opdtA         #verifica se $t1 � igual a 1 se for desvia para soma
			beq $t1,2,opdtS         #verifica se $t1 � igual a 2 se for desvia para subtracao
			beq $t1,3,opdtM    	#verifica se $t1 � igual a 3 se for desvia para multiplicacao	
			#--------------------#
		z: 
			jal valor1
			j contadiv
		contadiv:
			#--------------------# CONT PARA A DIV
			lwc1 $f5, lim
			lwc1 $f7, um
			add.s $f9, $f9, $f7
			c.eq.s $f9, $f5
			bc1t volta
			
			jal opdtD
			#--------------------#
		print_t:
 			li $v0, 1	
    			la $a0, ($t2) #print Valor
    			syscall
    	
    			#--------------------#
    			beq $t1,1,a         
			beq $t1,2,s         
			beq $t1,3,x   	
    			#--------------------#
			
		print_t2:
 			li $v0, 1	
    			la $a0, ($t3) #print Valor
    			syscall
    	
    			#--------------------#
    			beq $t1,1,a         
			beq $t1,2,s         
			beq $t1,3,x   	
    			#--------------------#
    		print_t3:
			li $v0, 1	
    			la $a0, ($t3) 	#print Valor
    			syscall
    		
			li $v0, 4
    			la $a0, i  	#print da = 
    			syscall
    			
    			li $v0, 1	
    			la $a0, ($t5) 	#print Valor
    			syscall
    			
    			li $v0, 4
    			la $a0, v  	#printa um espa�o vazio
    			syscall
    			
    			jal conta
    		print_t4:
    			li $v0, 1	
    			la $a0, ($t2) 	#print Valor
    			syscall
    		
			li $v0, 4
    			la $a0, i  	#print da = 
    			syscall
    			
    			li $v0, 1	
    			la $a0, ($t5) 	#print Valor
    			syscall
    			
    			li $v0, 4
    			la $a0, v 	#printa um espa�o vazio
    			syscall
   
    			jal conta 
    			
    		printd:
    			li $v0,2
			syscall 
    			
    			li $v0, 4
    			la $a0, i  	#print da = 
    			syscall
    			
    			add.s  $f12, $f6,$f3
    			li $v0, 2	
    			syscall		#print Valor
    			
    			li $v0, 4
    			la $a0, nd  	#print da /
    			syscall
    			
    			add.s  $f12, $f6,$f9
    			li $v0, 2	#print Valor
    			syscall
    			
    			li $v0, 4
    			la $a0, v  	#print da espa�o em branco 
    			syscall
   
    			jal contadiv   		
#--------------------------------------------------------------------------------------#           
	volta: 
		li $v0,4        #comando de impress�o de inteiro na tela
		la $a0, msgF    #coloca o msgF  para ser impresso
		syscall         # efetua a chamada ao sistema
	
		li $v0, 5       #le entrada do usu�rio
		syscall         #faz chamada ao sistema
	
		move $s3, $v0   # move conte�do de $v0 para $s3
	
		beq $s3, 1, op
		j termina       #desvia para termina
	resultado:
		li $v0,4               
		la $a0, msgR   #printa a mensagem RESULTADO
		syscall
		jr $ra
	print:
		li $v0,2     #comando de impress�o de float na tela
		syscall       # efetua a chamada ao sistema
		
		j volta
	termina:
		li $v0, 10    # comando de exit
		syscall       # efetua a chamada ao sistema
