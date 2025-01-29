%**************************************************************************
%                      Inteligência Computacional
% Algoritmo de otimização por enxame de partículas (PSO)
% Determina os minimos da função de Shubert: http://www.sfu.ca/~ssurjano/shubert.html
% Código fonte base obtido na internet e adpatado Edmarcio Belati - 2021.1
% Adaptações finais: Vinicius Teixeira
%**************************************************************************
close all hidden    % Apaga todas as figuras abertas
clear all           % Limpa todas as variaveis armazenadas no workspace
clc                 % Limpa o historico do prompt de comando
tic                 % Inicia contagem de tempo da aplicação
%% Parâmetros
c1=1.5;             % Fator de aprendizado individual
c2=2.5;             % Fator de aprendizado global
W_max=0.9;          % Peso de inércia máximo
W_min=0.4;          % Peso de inércia mínimo
M=50;               % Número de partículas
I_max=200;          % Número máximo de iterações
V_max=4;            % Intervalo de velocidade [-4, 4]
%% Problema 
N=2;				% Número de dimensões
X_max= [200,200];   % Limite superior das variáveis
X_min= [-200,-200]; % Limite inferior das variáveis
Func=@shubert;      % Invoca Função de Shubert
%% Loop principal   
Run=30;             % Numero de vezes que o algoritmo é executado
for tipo_w=1:4      % Define qual peso de inercia será utilizado
    % Imprime no Command Window qual peso de inércia será utilizado
    if tipo_w==1
    fprintf('W constante\n')
    elseif tipo_w==2
    fprintf('W Randomico\n')
    elseif tipo_w==3
    fprintf('W Decrescimo linear\n')
    else
    fprintf('W função sigmodal\n')
    end 
    for r=1:Run
        fprintf(2,['O algoritmo esta sendo executado pela: ',num2str(r),'\n']) % Imprime no Comamd Window quantas vezes o algoritmo esta sendo executado
        % Inicialização
        for i=1:M
             for j=1:N
                 x(i,j)=X_min(j)+rand()*(X_max(j)-X_min(j)); % Inicializa posição
                 v(i,j)=rand()*(X_max(j)-X_min(j)); % Inicializa velocidade
             end
             Fit(i,:)=Func(x(i,:)); % Avalia a função de Shubert
             Pb(i,:)=x(i,:);        % Inicializa melhor posição pessoal
        end
        % Obtém a melhor posição global
        [gb1,ind1]=sort(Fit); 
        Gb(r,:)=x(ind1(1,1),:);
    %% Loop secundário   
        for t=1:I_max
            
            t=t+1; 

            % Atualiza a posição e velocidade
            for i=1:M
                % Atualiza Pb
                if Func(x(i,:))<Fit(i)
                   Fit(i)=Func(x(i,:));
                   Pb(i,:)=x(i,:);
                end
                % Atualiza Gb
                if Func(Gb(r,:))>Fit(i)       
                   Gb(r,:)=Pb(i,:);
                end
                % Calcula o peso de inercia para cada uma das opções
                if tipo_w==1
                    w=0.7; % Constante
                elseif tipo_w==2
                    w=0.5+(rand()/2); % Randômico 
                elseif tipo_w==3
                    w=W_max-(W_max-W_min)*t/I_max; % Decrescimo linear
                else
                    u=10^((log(I_max)-2));
                    w=((W_max-W_min)/(1+exp(u*(t-I_max))))+W_max ; % Sigmoide
                end
                v(i,:)=w*v(i,:)+c1*rand*(Pb(i,:)-x(i,:))+c2*rand*(Gb(r,:)-x(i,:)); % Atualiza a velocidade
                
                % Verifica os limites da velocidade
                for j=1:N
                    if v(i,j)>V_max
                       v(i,j)=V_max;
                    elseif v(i,j)<-V_max
                       v(i,j)=-V_max;
                    end
                end
                % Atualiza a posição
                x(i,:)=x(i,:)+v(i,:);
            end
              Y(r,tipo_w)=Func(Gb(r,:)); % Armazena o melhor valor de fitness (melhor valor ajustado)
              x1(r,tipo_w)=Gb(r,1); % Armazena a melhor posição x1
              x2(r,tipo_w)=Gb(r,2); % Armazena a melhor posição x2
              % Plot, apenas para visualização
                if tipo_w==1
                    figure(1);
                    plot(t,Y(r,tipo_w),'r.'); % Constante
                elseif tipo_w==2
                    figure(2);
                    plot(t,Y(r,tipo_w),'b.'); % Randomico 
                elseif tipo_w==3
                    figure(3);
                    plot(t,Y(r,tipo_w),'m.'); % Decrescimo linear
                else
                   figure(4);
                   plot(t,Y(r,tipo_w),'k.'); % Sigmodal com pontos preto
                end 
            set(gca,'FontSize',14) % Ajusta as fonte dos eixos x e y para 14
            xlabel('Iteration');
            ylabel('Fitness');
            title(sprintf('The Best Fitness: %.15f',Y(r,tipo_w)),'FontSize',16);
            grid on;
            hold on;		
        end
    figure(5); % Gera o grafico da função de Shubert
    PlotShubert();
    set(gca,'FontSize',14) % Ajusta as fonte dos eixos x e y para 14
    hold on;
    if tipo_w==1
    scatter3(x1(r,tipo_w),x2(r,tipo_w),Y(r,tipo_w),'r', 'LineWidth', 4); % Plota os pontos em vermelho referente ao peso de inercia constante
    elseif tipo_w==2
    scatter3(x1(r,tipo_w),x2(r,tipo_w),Y(r,tipo_w),'b', 'LineWidth', 4); % Plota os pontos em azul referente ao peso de inercia randômico
    elseif tipo_w==3
    scatter3(x1(r,tipo_w),x2(r,tipo_w),Y(r,tipo_w),'m', 'LineWidth', 4); % Plota os pontos em magenta referente ao peso de inercia decrescimento linear
    else
    scatter3(x1(r,tipo_w),x2(r,tipo_w),Y(r,tipo_w),'k', 'LineWidth', 4); % Plota os pontos em preto referente ao peso de inercia função sigmodal
    end 
    end
end 
% Nomes dos tipos de peso de inércia
Names={'Peso de Inercia Constante','Peso de Inercia Randômico','Peso de Inercia Decrescimento Linear','Peso de Inercia Função Sigmoide'};
figure(6)
boxplot(Y,Names)
set(gca,'FontSize',14) % Ajusta as fonte dos eixos x e y para 14
grid on, box on

% Vetor utilizado para saída
resp=[(1:1:Run)' x1 x2 Y];%vetor utilizado para saída
fprintf(2,'             const.   Rand.   Decres.lin sigmoide    const.  Rand.    Decres.lin  sigmoide   const.   Rand.    Decres.lin  sigmoide           \n')
format short
fprintf(2,'    Run      x1        x1        x1        x1        x2        x2       x2        x2        Y         Y         Y         Y    \n')
disp(resp)
toc % Finaliza contagem de tempo da aplicação