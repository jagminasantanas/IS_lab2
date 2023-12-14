clear
close all
clc

% Aprašoma norima imituoti kreivė 
X_SK = 20;
x = 0.1:1/(X_SK+2):1;
y = ((1 + 0.6*sin(2*pi*x/0.7)) + 0.3*sin(2*pi*x))./2;
hold on
plot(x, y, '*')

% Pradimnės ryšių svorų reikšmės
NEURONU_SK = 6;
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
for k = 1:600000
    for x_nr = 1:X_SK
    
        % Tinklo atsako skaičiavimas FOR nusiimti 
        
            vj_1 = x(x_nr).*wj1_1+bj_1;
        
        % Aktyvavimo funkcija 1 sluoksnyje

            yj_1 = 1./(1.+exp(-vj_1));
        
        
        % Pasverta suma išėjimo sluoksnyje
        v1_2(x_nr) = b1_2 + sum(yj_1.*w1j_2);
        
        % Tinklo atsako aktyvavimo funkcija
        y_isejimo(x_nr) = v1_2(x_nr);
        
        % Apskaičiuojama klaida
        e1 = y(x_nr) - y_isejimo(x_nr);
    
        % Atnaujinami ryšių svoriai
        % Formulė = w + lstep*delta*input
    
        delta_out1 = e1;
        
            delta_j_1 = yj_1.*(1-yj_1).*(delta_out1.*w1j_2);
            
        % atnaujinami svoriai išėjimo sluoksnyje
            w1j_2 =  w1j_2 + STEP.*delta_out1.*yj_1;
    
        b1_2 = b1_2 + STEP*delta_out1;
        % Atnaujinami svoriai paslėptajame sluoksnyje
    
            wj1_1 = wj1_1 + STEP.*delta_j_1.*x(x_nr);
            bj_1 = bj_1 + STEP.*delta_j_1;
    
    end
end
X2_SK = 100;
x = 0.1:(1/(X2_SK-1)):1;
for x_nr = 1:X2_SK-(X2_SK*x(1))
    % Tinklo atsako skaičiavimas
    for i = 1:NEURONU_SK
        vj_1(i) = x(x_nr)*wj1_1(i)+bj_1(i);        
    % Aktyvavimo funkcija 1 sluoksnyje    
        yj_1(i) = 1/(1+exp(-vj_1(i)));
    end
    
    % Pasverta suma išėjimo sluoksnyje
    v1_2(x_nr) = b1_2 + sum(yj_1.*w1j_2);
    
    % Tinklo atsako aktyvavimo funkcija
    y_isejimo(x_nr) = v1_2(x_nr);
end

plot(x, y_isejimo)
hold off
