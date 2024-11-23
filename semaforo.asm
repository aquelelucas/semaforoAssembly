.org 0000H       ; Início do programa na posição de memória 0x0000

; Sub-rotina de atraso (aproximadamente 1 segundo)
DELAY_1S:
        LXI D, 65535     ; Carregar valor grande para delay
DELAY_LOOP:
        DCX D           ; Decrementar contador
        MOV A, D        ; Verificar se contador chegou a 0
        ORA E
        JNZ DELAY_LOOP  ; Se não for 0, repetir
        RET

; Sub-rotina de atraso de X segundos
DELAY_XS:
        MVI B, 0         ; Registrar para contar X segundos
DELAY_X_LOOP:
        CALL DELAY_1S    ; Chamar atraso de 1 segundo
        DCR B            ; Decrementar X
        JNZ DELAY_X_LOOP ; Repetir até que B seja 0
        RET

; Programa principal
START:
        ; Semáforo 1: verde (01H), amarelo (02H), vermelho (03H)
        ; Semáforo 2: verde (04H), amarelo (05H), vermelho (06H)

        ; Inicialização: Semáforo 1 verde (00H), Semáforo 2 vermelho (05H)
        MVI A, 01H
        OUT 00H          ; LED verde semáforo 1
        MVI A, 00H
        OUT 01H          ; Apagar LED amarelo semáforo 1
        MVI A, 00H
        OUT 02H          ; Apagar LED vermelho semáforo 1

        MVI A, 00H
        OUT 03H          ; Apagar LED verde semáforo 2
        MVI A, 00H
        OUT 04H          ; Apagar LED amarelo semáforo 2
        MVI A, 01H
        OUT 05H          ; LED vermelho semáforo 2

        MVI B, 55        ; 55 segundos para o semáforo verde
        CALL DELAY_XS

        ; Semáforo 1: amarelo (02H), Semáforo 2: vermelho (06H)
        MVI A, 00H
        OUT 00H          ; Apagar LED verde semáforo 1
        MVI A, 02H
        OUT 01H          ; LED amarelo semáforo 1
        MVI A, 00H
        OUT 02H          ; Apagar LED vermelho semáforo 1

        MVI A, 00H
        OUT 03H          ; Apagar LED verde semáforo 2
        MVI A, 00H
        OUT 04H          ; Apagar LED amarelo semáforo 2
        MVI A, 01H
        OUT 05H          ; LED vermelho semáforo 2
        MVI B, 5         ; 5 segundos para o semáforo amarelo
        CALL DELAY_XS

        ; Semáforo 1: vermelho (03H), Semáforo 2: verde (04H)
        MVI A, 00H
        OUT 00H          ; Apagar LED verde semáforo 1
        MVI A, 00H
        OUT 01H          ; Apagar LED amarelo semáforo 1
        MVI A, 03H
        OUT 02H          ; LED vermelho semáforo 1

        MVI A, 01H
        OUT 03H          ; LED verde semáforo 2
        MVI A, 00H
        OUT 04H          ; Apagar LED amarelo semáforo 2
        MVI A, 00H
        OUT 05H          ; Apagar LED vermelho semáforo 2
        MVI B, 55        ; 55 segundos para o semáforo verde
        CALL DELAY_XS

        ; Semáforo 1: vermelho (03H), Semáforo 2: amarelo (05H)
        MVI A, 00H
        OUT 00H          ; Apagar LED verde semáforo 1
        MVI A, 00H
        OUT 01H          ; Apagar LED amarelo semáforo 1
        MVI A, 03H
        OUT 02H          ; LED vermelho semáforo 1

        MVI A, 00H
        OUT 03H          ; Apagar LED verde semáforo 2
        MVI A, 05H
        OUT 04H          ; LED amarelo semáforo 2
        MVI A, 00H
        OUT 05H          ; Apagar LED vermelho semáforo 2
        MVI B, 5         ; 5 segundos para o semáforo amarelo
        CALL DELAY_XS

        JMP START        ; Repetir o ciclo