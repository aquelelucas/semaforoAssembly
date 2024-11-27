.org 0000H       

START:
    ; Fase 1: Semáforo 1 verde, Semáforo 2 vermelho
FASE1:
    MVI A, C0H
    OUT 00H             ; Acende LED verde do semáforo 1
    OUT 01H             ; Acende LED verde do semáforo 1

    MVI A, 00H
    OUT 02H             ; Apaga LED amarelo de ambos os semáforos
    OUT 03H             ; Apaga LED amarelo de ambos os semáforos

    MVI A, 03H
    OUT 04H             ; Acende LED vermelho do semáforo 2
    OUT 05H             ; Acende LED vermelho do semáforo 2

    CALL DELAY_15_MONITOR  ; 15s de delay com monitoramento dos botões

    ; Fase 2: Semáforo 1 amarelo, Semáforo 2 vermelho
FASE2:
    MVI A, 00H
    OUT 00H             ; Apaga LED verde do semáforo 1
    OUT 01H             ; Apaga LED verde do semáforo 1

    MVI A, C0H
    OUT 02H             ; Acende LED amarelo do semáforo 1
    OUT 03H             ; Acende LED amarelo do semáforo 1

    MVI A, 03H
    OUT 04H             ; Mantém LED vermelho do semáforo 2
    OUT 05H             ; Mantém LED vermelho do semáforo 2

    CALL DELAY_5        ; 5s de delay

    ; Fase 3: Semáforo 1 vermelho, Semáforo 2 verde
    MVI A, 03H
    OUT 00H             ; Acende LED verde no semáforo 2
    OUT 01H             ; Acende LED verde no semáforo 2

    MVI A, 00H
    OUT 02H             ; Apaga LED amarelo de ambos os semáforos
    OUT 03H             ; Apaga LED amarelo de ambos os semáforos

    MVI A, C0H
    OUT 04H             ; Acende LED vermelho no semáforo 1
    OUT 05H             ; Acende LED vermelho no semáforo 1

    CALL DELAY_15_MONITOR  ; 15s de delay com monitoramento dos botões

    ; Fase 4: Semáforo 1 vermelho, Semáforo 2 amarelo
FASE4:
    MVI A, 00H
    OUT 00H             ; Apaga LED verde do semáforo 2
    OUT 01H             ; Apaga LED verde do semáforo 2

    MVI A, 03H
    OUT 02H             ; Acende LED amarelo do semáforo 2
    OUT 03H             ; Acende LED amarelo do semáforo 2

    MVI A, C0H
    OUT 04H             ; Mantém LED vermelho do semáforo 1
    OUT 05H             ; Mantém LED vermelho do semáforo 1

    CALL DELAY_5        ; 5s de delay

    JMP FASE1           ; Repetir o ciclo

; Sub-rotina para monitorar os botões durante o atraso
MONITOR_BOTAO:
    IN 08H              ; Lê o estado dos botões (endereços 08H)
    ANI 8CH             ; Verifica se o botão 1 foi pressionado
    JNZ FASE2           ; Se botão 1 pressionado, vai para fase 2

    IN 08H              ; Lê novamente o estado dos botões
    ANI 40H             ; Verifica se o botão 2 foi pressionado
    JNZ FASE4           ; Se botão 2 pressionado, vai para fase 4

    RET                 ; Retorna ao programa principal se nenhum botão foi pressionado

; Sub-rotina de atraso de 1 segundo
DELAY_1:
    MVI B, 120          ; 120 ciclos de clock a 10% da velocidade, +/- 1 seg
DELAY_1_LOOP:
    NOP                 ; Contador de ciclos
    NOP                 ; Cada NOP consome um ciclo de clock
    DCR B               ; Decrementa o contador
    JNZ DELAY_1_LOOP    ; Se B não for zero, repete o loop
    RET                 

; Sub-rotina de atraso de 5 segundos
DELAY_5:
    MVI C, 5            ; Configura 5 segundos
DELAY_5_LOOP:
    CALL DELAY_1        ; Chama atraso de 1 segundo
    DCR C               ; Decrementa o contador de segundos
    JNZ DELAY_5_LOOP    ; Repete até completar 5 segundos
    RET

    ; Sub-rotina de atraso com monitoramento contínuo - 15 segundos
DELAY_15_MONITOR:
    MVI C, 15
DELAY_15_LOOP:
    CALL DELAY_1        ; Atraso de 1 segundo
    CALL MONITOR_BOTAO  ; Verifica os botões durante o atraso
    DCR C
    JNZ DELAY_15_LOOP
    RET