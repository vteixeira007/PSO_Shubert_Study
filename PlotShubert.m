function PlotShubert()
% Função para plotar a função de Shubert em 2 dimensões

    [X,Y] = meshgrid(-100:100,-100:100); % Cria uma grade de valores de X e Y no intervalo de -100 a 100
    N = size(X,1); % Obtém o tamanho da grade
    
    % Inicializa a matriz Z para armazenar os valores da função de Shubert
    Z = zeros(N, N);

    % Calcula os valores da função de Shubert para cada ponto na grade
    for i = 1:N
        for j = 1:N
            z = [X(i,j),Y(i,j)]; % Cria um vetor com as coordenadas (X, Y)
            Z(i,j) = shubert (z); % Avalia a função de Shubert no ponto (X, Y)
        end
    end
    
    mesh(X,Y,Z); % Plota a superfície da função de Shubert
    title('Shubert Function in 2 dimension','FontSize',14);

end