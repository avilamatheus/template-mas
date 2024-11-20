// Agente entregador

/* Crenças iniciais */
posicao(0, 0).
entregas([posicao(2,3), posicao(4,5), posicao(8,8)]).
entregas_realizadas([]).

/* Objetivo inicial */
!inicializar_entregador.

+!inicializar_entregador : posicao(Xinicial, Yinicial)
  <-  .print("Inicializando entregador...");
      .print("Posição inicial: ", Xinicial, ",", Yinicial);
      .wait(2500);
      !!realizar_entregas.

+!realizar_entregas: entregas([Destino | Resto])
  <-  .print("Próxima entrega: ", Destino);
      .wait(2500);
      !mover_para(Destino);
      !marcar_entrega_feita(Destino);
      -entregas([Destino | Resto]);
      +entregas(Resto);
      !!realizar_entregas.

+!realizar_entregas: entregas([])
  <-  .print("Todas as entregas foram realizadas com sucesso!").

+!mover_para(posicao(Xdestino, Ydestino)) : posicao(Xinicial, Yinicial)
  <- .print("Posição atual: (", Xinicial, ",", Yinicial, ")");
     .print("Iniciando movimentação para: (", Xdestino, ",", Ydestino, ")");
     .wait(2500);
     !mover(Xinicial, Yinicial, Xdestino, Ydestino).

+!mover(X, Y, Xf, Yf): (X == Xf & Y == Yf)
  <-  .print("Cheguei ao destino: (", Xf, ",", Yf, ")");
      .wait(2500);
      +posicao(Xf, Yf).

+!mover(X, Y, Xf, Yf): (X < Xf)
  <-  NovoX = X + 1;
      .print("Movendo para a direita: (", NovoX, ",", Y, ")");
      .wait(2500);
      -posicao(X, Y);
      +posicao(NovoX, Y);
      !mover(NovoX, Y, Xf, Yf).

+!mover(X, Y, Xf, Yf): (X > Xf)
  <-  NovoX = X - 1;
      .print("Movendo para a esquerda: (", NovoX, ",", Y, ")");
      .wait(2500);
      -posicao(X, Y);
      +posicao(NovoX, Y);
      !mover(NovoX, Y, Xf, Yf).

+!mover(X, Y, Xf, Yf): (Y < Yf)
  <-  NovoY = Y + 1;
      .print("Movendo para cima: (", X, ",", NovoY, ")");
      .wait(2500);
      -posicao(X, Y);
      +posicao(X, NovoY);
      !mover(X, NovoY, Xf, Yf).

+!mover(X, Y, Xf, Yf): (Y > Yf)
  <-  NovoY = Y - 1;
      .print("Movendo para baixo: (", X, ",", NovoY, ")");
      .wait(2500);
      -posicao(X, Y);
      +posicao(X, NovoY);
      !mover(X, NovoY, Xf, Yf).

+!marcar_entrega_feita(Destino)
  <-  -entregas_realizadas(Realizadas);
      +entregas_realizadas([Destino | Realizadas]);
      .print("Entrega concluída em: ", Destino);
      .wait(2500).