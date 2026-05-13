.data
str1: .asciiz "Resultado da raiz: "
str2: .asciiz "\nDigite um número que deseja calcular a raiz: "
str3: .asciiz "\nDeseja continuar calculando as raízes de números? 1 - SIM / 0 - NÃO: "
str4: .asciiz "Encerrando o programa de cálculo de raízes..."
str_err: .asciiz "Erro! O número digitado não possui uma raiz quadrada perfeita. Tente novamente.\n"
.text
.globl main

main:
li $t5, 0
li $t6, 10

loop:
# imprimindo a str2
li $v0, 4
la $a0, str2
syscall

# recebendo o número do terminal
li $v0, 5
syscall
move $s0, $v0 # x

addi $t0, $zero, 0 # t
addi $t1, $zero, 1 # r
addi $t2, $zero, 2 # d
addi $t3, $zero, 4 # s

while:
bne $t0, $zero, res
addi $t1, $t1, 1 # r = r + 1
addi $t2, $t2, 2 # d = d + 2
add $t3, $t3, $t2 # s = s + d
addi $t3, $t3, 1 # s = s + 1
slt $t0, $s0, $t3 # x < s
j while

res:
# verificando se o número digitado possui raiz
mult $t1, $t1
mflo $t7
bne $t7, $s0, err

# imprimindo a str1
li $v0, 4
la $a0, str1
syscall

# imprimindo o r
li $v0, 1
la $a0, ($t1)
syscall

# aumentando o incrementador
addi $t5, $t5, 1

# imprimindo a str3
li $v0, 4
la $a0, str3
syscall

# recebendo a resposta no terminal
li $v0, 5
syscall
move $t4, $v0
beq $t5, $t6, end
beq $t4, 1, loop
beq $t4, $zero, end

# caso de erro
err:
# imprimindo a mensagem de erro
li $v0, 4
la $a0, str_err
syscall
j loop

# encerrado o programa
end:
li $v0, 4
la $a0, str4
syscall
li $v0, 10
syscall