## ==================================
## Prácticas de Fundamentos Físicos de la Informática.
## Práctica 2. Programado por Darío Pérez y Nielsen Casado.
## ==================================
## Variables de carga
q = 1e-9;
## __________________________________
## Variables de posición
x0 = 1;
a = 2; b = 5;
x = [a:0.1:b];
r = abs(x-x0);
## ==================================

function e = coulomb(q, r) # Experimentamos aquí con la creación de funciones reutilizables en Octave, aunque no es necesario para el desarrollo de esta práctica, creemos que era importante para un correcto uso, cuando sea usado de manera más extensa, de la herramienta.
  k = 9e9;
  e = (k * q)./r.^2;
end

## Creamos aquí la gráfica, inicializada por figure(), dibujada por plot(), con los datos de distancia y campo eléctrico de cada punto; y estilizada con xlabel, ylabel, y title.
figure();
plot(r, coulomb(q, r), "linestyle", "-", "linewidth", 2, "r")
xlabel("x (m)", "FontWeight", "bold", "FontAngle", "italic", "FontSize", 16) %Aplicar estilo en label X
ylabel("E (N/C)", "FontWeight", "bold", "FontAngle", "italic", "FontSize", 16) %Aplicar estilo en label Y
title("\nCampo eléctrico de una carga puntual sobre un intervalo en el eje X\n", "FontWeight", "bold", "FontAngle", "italic", "FontSize", 16) %Aplicar estilo en Título
