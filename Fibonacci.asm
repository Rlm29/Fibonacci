# Programa MIPS para calcular o 30° e o 41° termos da sequência de Fibonacci
# e calcular a razão áurea (phi) usando esses valores.

.data
newline: .asciiz "\n"
fib30_msg: .asciiz "30º número de Fibonacci: "
fib41_msg: .asciiz "41º número de Fibonacci: "
fib40_msg: .asciiz "40º número de Fibonacci: "
phi_msg: .asciiz "Razão áurea (phi): "

.text
.globl main

main:
    # Calcula o 30° termo da série de Fibonacci
    li $a0, 30        # Coloca 30 em $a0
    jal fibonacci     # Chama a função fibonacci
    move $s1, $v0     # Move o resultado para $s1
    
    # Calcula o 41° termo da série de Fibonacci
    li $a0, 41        # Coloca 41 em $a0
    jal fibonacci     # Chama a função fibonacci
    move $s2, $v0     # Move o resultado para $s2

    # Calcula o 40° termo da série de Fibonacci
    li $a0, 40        # Coloca 40 em $a0
    jal fibonacci     # Chama a função fibonacci
    move $s3, $v0     # Move o resultado para $s3

    # Calcula a razão áurea (phi)
    mtc1 $s2, $f4      # Move o valor de F(41) para $f4
    mtc1 $s3, $f6      # Move o valor de F(40) para $f6
    cvt.s.w $f4, $f4   # Converte F(41) para float
    cvt.s.w $f6, $f6   # Converte F(40) para float
    div.s $f0, $f4, $f6 # Divide F(41) por F(40) para obter phi

    # Imprime o 30° termo da série de Fibonacci
    li $v0, 4            # Chamada de sistema para impressão de string
    la $a0, fib30_msg    # Carrega o endereço da mensagem
    syscall
    li $v0, 1            # Chamada de sistema para impressão de inteiro
    move $a0, $s1        # Move o valor de $s1 para $a0
    syscall
    li $v0, 4            # Chamada de sistema para impressão de string
    la $a0, newline      # Carrega o endereço da nova linha
    syscall

    # Imprime o 41° termo da série de Fibonacci
    li $v0, 4            # Chamada de sistema para impressão de string
    la $a0, fib41_msg    # Carrega o endereço da mensagem
    syscall
    li $v0, 1            # Chamada de sistema para impressão de inteiro
    move $a0, $s2        # Move o valor de $s2 para $a0
    syscall
    li $v0, 4            # Chamada de sistema para impressão de string
    la $a0, newline      # Carrega o endereço da nova linha
    syscall

    # Imprime o 40° termo da série de Fibonacci
    li $v0, 4            # Chamada de sistema para impressão de string
    la $a0, fib40_msg    # Carrega o endereço da mensagem
    syscall
    li $v0, 1            # Chamada de sistema para impressão de inteiro
    move $a0, $s3        # Move o valor de $s3 para $a0
    syscall
    li $v0, 4            # Chamada de sistema para impressão de string
    la $a0, newline      # Carrega o endereço da nova linha
    syscall

    # Imprime a razão áurea (phi)
    li $v0, 4            # Chamada de sistema para impressão de string
    la $a0, phi_msg      # Carrega o endereço da mensagem
    syscall
    li $v0, 2            # Chamada de sistema para impressão de ponto flutuante
    mov.s $f12, $f0      # Move o valor de $f0 para $f12
    syscall
    li $v0, 4            # Chamada de sistema para impressão de string
    la $a0, newline      # Carrega o endereço da nova linha
    syscall

    # Finaliza o programa
    li $v0, 10
    syscall

# Função para calcular o n-ésimo termo da sequência de Fibonacci
# Entrada: $a0 - o valor de n
# Saída: $v0 - o n-ésimo termo da sequência de Fibonacci
fibonacci:
    # Verifica se n == 0
    beqz $a0, fib_base_case_0
    # Verifica se n == 1
    li $t0, 1
    beq $a0, $t0, fib_base_case_1

    # Inicializa os valores iniciais da sequência
    li $t1, 0        # F(0)
    li $t2, 1        # F(1)
    li $t3, 2        # Contador de loop
    li $t4, 0        # Variável temporária para armazenar F(n)

fib_loop:
    bgt $t3, $a0, fib_end_loop # Sai do loop se contador > n
    add $t4, $t1, $t2          # Calcula F(n) = F(n-1) + F(n-2)
    move $t1, $t2              # Atualiza F(n-2) para o próximo passo
    move $t2, $t4              # Atualiza F(n-1) para o próximo passo
    addi $t3, $t3, 1           # Incrementa o contador
    j fib_loop                 # Continua o loop

fib_end_loop:
    move $v0, $t2              # O resultado é F(n) em $t2
    jr $ra                     # Retorna da função

fib_base_case_0:
    li $v0, 0                  # Se n == 0, retorna 0
    jr $ra

fib_base_case_1:
    li $v0, 1                  # Se n == 1, retorna 1
    jr $ra
