## ==================================
## Prácticas de Fundamentos Físicos de la Informática.
## Práctica 4. Programado por Darío Pérez y Nielsen Casado.
## ==================================
## Definimos parámetros globales, editables via interfaz.
global resolucionVarilla = 100000; % Número de cargas en la varilla
global resolucionIntervalo = 50; % Número de puntos en los que calcular n
## ==================================
## Creamos la interfaz de gráficas y control de parámetros.

figure('color', [0.95, 0.95, 0.95]);
comparisonSubplot = subplot(1, 2, 1)
##errorSubplot = subplot(1, 2, 2)
set(comparisonSubplot, "position", [0.075 0.3 0.35 0.6])
##set(errorSubplot, "position", [0.6 0.3 0.35 0.6])

global errorLabel # Añadida como global para poder ser editada al cambiar las resoluciones.
errorLabel = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Error: ",
                           "horizontalalignment", "left",
                           "position", [0.05 0 0.65 0.04]);

resolucionVarillaSliderLabel = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "resolucionVarilla: 100000",
                           "horizontalalignment", "left",
                           "position", [0.05 0.1 0.65 0.04]);

resolucionVarillaSlider = uicontrol('Style', 'slider',...
    'Min',0,'Max',7,'Value',5,...
    'Units', 'Normalized',...
    'Position', [0.3 0.1 0.4 0.04],...
    'Callback', {@changeResolucionVarilla, resolucionVarillaSliderLabel},...
    'SliderStep', [1/7 1]);

function changeResolucionVarilla(resolucionVarillaSlider, callbackdata, resolucionVarillaSliderLabel)
  global resolucionVarilla
    resolucionVarilla = get(resolucionVarillaSlider, "value");
    resolucionVarilla = round(resolucionVarilla);
    set(resolucionVarillaSliderLabel, 'String', ['resolucionVarilla: ' num2str(10^resolucionVarilla)]);
    set(resolucionVarillaSlider, 'Value', resolucionVarilla);
##    disp(['resolucionVarilla cambió a ' num2str(resolucionVarilla)]);
    printPlot()
end


resolucionIntervaloSliderLabel = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "resolucionIntervalo: 50",
                           "horizontalalignment", "left",
                           "position", [0.05 0.05 0.65 0.04]);
resolucionIntervaloSlider = uicontrol('Style', 'slider',...
    'Min',2,'Max',100,'Value',50,...
    'Units', 'Normalized',...
    'Position', [0.3 0.05 0.4 0.04],...
    'Callback', {@changeresolucionIntervalo, resolucionIntervaloSliderLabel},...
    'SliderStep', [1/100 1]);

function changeresolucionIntervalo(resolucionIntervaloSlider, callbackdata, resolucionIntervaloSliderLabel)
  global resolucionIntervalo
    resolucionIntervalo = get(resolucionIntervaloSlider, "value");
    resolucionIntervalo = round(resolucionIntervalo);
    set(resolucionIntervaloSliderLabel, 'String', ['resolucionIntervalo: ' num2str(resolucionIntervalo)]);
    set(resolucionIntervaloSlider, 'Value', resolucionIntervalo);
##    disp(['resolucionIntervalo cambió a ' num2str(resolucionIntervalo)]);
    printPlot()
end
## ==================================

## Finalmente, creamos una gráfica de comparación de E analítica y numérica, actualizable con la función "printPlot", y llamada cada vez que cambia resolucionIntervalo o resolucionVarilla.
function printPlot()
## ==================================
## Importamos variables globales
  global resolucionVarilla
  global resolucionIntervalo
  global errorLabel
## __________________________________
## Variables de carga
  Q = 100e-9;
  L = 1;
## Como no podemos hacer una varilla continua, la cuantizamos en cachitos, cuyo número es establecido con resolucionVarilla.
  dL = L/((10^resolucionVarilla)-1);
  x0 = [0:dL:L];
  q = Q/(10^resolucionVarilla);
## __________________________________
## Variables de posición
  a = 1.2;
  b = 4;
  dx = (b-a)/(resolucionIntervalo-1);
  x = [a:dx:b];
## __________________________________
## Creamos una matriz vacía, que más tarde llenaremos con los valores del Campo Electrico en cada punto de X donde lo miremos.
  E = zeros(1, resolucionIntervalo);
## __________________________________
## Definimos k.
  k = 9e9;


  for i = 1:resolucionIntervalo
    Ex = k*q./(x(i)-x0).^2;
    E(i) = sum(Ex);
  end

  EAnalitica = k*Q./(x.*(x-L));

##  Actualizamos la gráfica de comparación
  comparisonSubplot = subplot(1, 2, 1);
  plot(x,E,'x',x,EAnalitica,'black')
  grid on
  xlabel("\nx (m)", "FontWeight", "bold", "FontAngle", "italic", "FontSize", 15) %Aplicar estilo en label X
  ylabel("E (N/C)\n\n", "FontWeight", "bold", "FontAngle", "italic", "FontSize", 15) %Aplicar estilo en label y
  title("Campo eléctrico analítico vs numérico", "FontWeight", "bold", "FontAngle", "italic", "FontSize", 15) %Aplicar estilo en título
  set(comparisonSubplot, "position", [0.075 0.3 0.9 0.6])

##  Actualizamos la etiquetilla de Error
  errorVal = sum(abs(E-EAnalitica))/resolucionIntervalo
  set(errorLabel, 'String', ['Error: ' num2str(errorVal)]);

end

printPlot()

