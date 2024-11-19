// Agente entregador

/* Crenças iniciais */
posicao(0, 0).
entregas([posicao(2,3), posicao(4,5)]).
entregas_realizadas([]).

/* Objetivo inicial */
!inicializar_entregador.

+!inicializar_entregador : posicao(Xinicial, Yinicial)
  <-  .print("Inicializando entregador...");
      .print("Posição inicial: ", Xinicial, ",", Yinicial);
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

+!mover_para(posicao(Xdestino, Ydestino)) : posicao(Xinicial, Yinicial)
  <- .print("Extraindo destino: ", Xdestino, ",", Ydestino);
     .print("Posição atual: (", Xinicial, ",", Yinicial, ")");
     .print("Iniciando movimentação para: (", Xdestino, ",", Ydestino, ")");
     !mover(Xinicial, Yinicial, Xdestino, Ydestino).

+!mover(X, Y, Xf, Yf): (X == Xf & Y == Yf)
  <-  .print("Cheguei ao destino: (", Xf, ",", Yf, ")");
      +posicao(Xf, Yf).

+!mover(X, Y, Xf, Yf): (X < Xf)
  <-  NovoX = X + 1;
      .print("Movendo para a direita: (", NovoX, ",", Y, ")");
      -posicao(X, Y);
      +posicao(NovoX, Y);
      !mover(NovoX, Y, Xf, Yf).

+!mover(X, Y, Xf, Yf): (X > Xf)
  <-  NovoX = X - 1;
      .print("Movendo para a esquerda: (", NovoX, ",", Y, ")");
      -posicao(X, Y);
      +posicao(NovoX, Y);
      !mover(NovoX, Y, Xf, Yf).

+!mover(X, Y, Xf, Yf): (Y < Yf)
  <-  NovoY = Y + 1;
      .print("Movendo para cima: (", X, ",", NovoY, ")");
      -posicao(X, Y);
      +posicao(X, NovoY);
      !mover(X, NovoY, Xf, Yf).

+!mover(X, Y, Xf, Yf): (Y > Yf)
  <-  NovoY = Y - 1;
      .print("Movendo para baixo: (", X, ",", NovoY, ")");
      -posicao(X, Y);
      +posicao(X, NovoY);
      !mover(X, NovoY, Xf, Yf).

+!marcar_entrega_feita(Destino)
  <-  -entregas_realizadas(Realizadas);
      +entregas_realizadas([Destino | Realizadas]);
      .print("Entrega concluída em: ", Destino).