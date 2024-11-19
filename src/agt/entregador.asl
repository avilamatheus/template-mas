// Agente entregador

/* Crenças iniciais */
posicao(0, 0).
entregas([(2, 3), (4, 5)]).
entregas_realizadas([]).

/* Objetivo inicial */
!inicializar_entregador.

+!inicializar_entregador
  <-  .print("Inicializando entregador...");
      .print("Posição inicial: ", posicao);
      .print("Entregas a realizar: ", entregas);
      !!realizar_entregas.

+alterado : posicao(X, Y)
  <-  .print("A posição do entregador foi atualizada para: (", X, ",", Y, ")");
      !!realizar_entregas.

+!realizar_entregas: entregas([Destino | Resto])
  <-  .print("Próxima entrega: ", Destino);
      !mover_para(Destino);
      !marcar_entrega_feita(Destino);
      -entregas([Destino | Resto]);
      +entregas(Resto);
      !!realizar_entregas.

+!realizar_entregas: entregas([])
  <-  .print("Todas as entregas foram realizadas com sucesso!").