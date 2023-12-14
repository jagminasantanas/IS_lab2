clear
close all
clc

X_SK = 20;
z = zeros(X_SK);
i = 1; j = 1;
for x = 0.1:1/(X_SK+2):1    
    for y = 0.1:1/(X_SK+2):1
        z(i,j) = ((1 + 0.6*sin(2*pi*(y)/0.7)) + 0.3*sin(2*pi*(y)))./2;
        j = j + 1;
    end
    j = 1;
    i = i + 1;
end
x = 0.1:1/(X_SK+2):1;
y = 0.1:1/(X_SK+2):1;
figure
ax = gca;
mesh(x, y, z)
hold on
x = 0.1:1/(X_SK+2):1;
% Pradimnės ryšių svorių reikšmės
NEURONU_SK = 4;
% 1 sluoksnio svoriai
for i = 1:NEURONU_SK
    % Į j neuroną 1 sluoksnyje iš 1 įėjimo
    wj1_1(i) = rand(1);
    bj_1(i) = rand(1);

    % 2 sluoksnio svoriai
    % į 1-ąjį neuroną 2 sluoksnyje iš j neurono
    w1j_2(i) = rand(1);
end
b1_2 = rand(1);
STEP = 0.1;
vj_1 = [1,NEURONU_SK];
yj_1 = [1,NEURONU_SK];
v1_2 = [X_SK,X_SK];
z_isejimo = [X_SK,X_SK];
delta_j_1 = [1, NEURONU_SK];
for k = 1:10000
    for x_nr = 1:X_SK
        for y_nr = 1:X_SK
            % Tinklo atsako skaičiavimas
            for i = 1:NEURONU_SK
                vj_1(i) = x(y_nr)*wj1_1(i)+bj_1(i);
            
            % Aktyvavimo funkcija 1 sluoksnyje
    
                yj_1(i) = 1/(1+exp(-vj_1(i)));
            end
            
            % Pasverta suma išėjimo sluoksnyje
            v1_2(x_nr, y_nr) = b1_2 + sum(yj_1.*w1j_2);
            
            % Tinklo atsako aktyvavimo funkcija
            z_isejimo(x_nr, y_nr) = v1_2(x_nr, y_nr);
            
            % Apskaičiuojama klaida
            e1 = z(x_nr, y_nr) - z_isejimo(x_nr, y_nr);
        
            % Atnaujinami ryšių svoriai
            % Formulė = w + lstep*delta*input
        
            delta_out1 = e1;
            
            for i = 1:NEURONU_SK
                delta_j_1(i) = yj_1(i)*(1-yj_1(i))*(delta_out1*w1j_2(i));
                
            % atnaujinami svoriai išėjimo sluoksnyje
                w1j_2(i) =  w1j_2(i) + STEP*delta_out1*yj_1(i);
            end
        
            b1_2 = b1_2 + STEP*delta_out1;
            % Atnaujinami svoriai paslėptajame sluoksnyje
        
            for i = NEURONU_SK
                wj1_1(i) = wj1_1(i) + STEP*delta_j_1(i)*x(y_nr);
                bj_1(i) = bj_1(i) + STEP*delta_j_1(i);
            end
        end
    end
end
X2_SK = 100;
x = 0.1:1/(X2_SK-1):1;
y = 0.1:1/(X2_SK-1):1;
for x_nr = 1:X2_SK-(X2_SK*x(1))
    for y_nr = 1:X2_SK-(X2_SK*x(1))
        % Tinklo atsako skaičiavimas
        for i = 1:NEURONU_SK
            vj_1(i) = y(y_nr)*wj1_1(i)+bj_1(i);        
        % Aktyvavimo funkcija 1 sluoksnyje    
            yj_1(i) = 1/(1+exp(-vj_1(i)));
        end
        
        % Pasverta suma išėjimo sluoksnyje
        v1_2(x_nr, y_nr) = b1_2 + sum(yj_1.*w1j_2);
        
        % Tinklo atsako aktyvavimo funkcija
        z_isejimo(x_nr, y_nr) = v1_2(x_nr, y_nr);
    end
end
mesh( x, y, z_isejimo, 'FaceColor','r');
hold off

