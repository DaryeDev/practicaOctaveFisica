## ==================================
## Prácticas de Fundamentos Físicos de la Informática.
## Práctica 2. Programado por Darío Pérez y Nielsen Casado.
## ==================================
## Variables de carga
q = 1e-9;
## __________________________________
## Variables de posición
x0 = 1;
x = 3;
r = abs(x - x0);
## ==================================

function e = coulomb(q, r) # Experimentamos aquí con la creación de funciones reutilizables en Octave, aunque no es necesario para el desarrollo de esta práctica, creemos que era importante para un correcto uso, cuando sea usado de manera más extensa, de la herramienta.
  k = 9e9;
  e = (k * q)./r.^2;
end

## Imprimimos los resultados por consola.
fprintf("La carga puntual %dC situada en X %d, sobre el punto en X %d, genera un campo eléctrico, cuyo módulo es %d\n", q, x0, x, coulomb(q, r))
