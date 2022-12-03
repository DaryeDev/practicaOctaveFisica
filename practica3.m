## ==================================
## Prácticas de Fundamentos Físicos de la Informática.
## Práctica 3. Programado por Darío Pérez y Nielsen Casado.
## ==================================
## Definimos parámetros globales, editables via interfaz.
global resolucionVarilla = 100000; % Número de cargas en la varilla
global resolucionIntervalo = 50; % Número de puntos en los que calcular n
## ==================================
## Creamos la interfaz de gráficas y control de parámetros.

figure('color', [0.95, 0.95, 0.95]);
grid on;
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
    'Callback', {@changeResolucionIntervalo, resolucionIntervaloSliderLabel},...
    'SliderStep', [1/100 1]);

function changeResolucionIntervalo(resolucionIntervaloSlider, callbackdata, resolucionIntervaloSliderLabel)
  global resolucionIntervalo
    resolucionIntervalo = get(resolucionIntervaloSlider, "value");
    resolucionIntervalo = round(resolucionIntervalo);
    set(resolucionIntervaloSliderLabel, 'String', ['resolucionIntervalo: ' num2str(resolucionIntervalo)]);
    set(resolucionIntervaloSlider, 'Value', resolucionIntervalo);
##    disp(['resolucionIntervalo cambió a ' num2str(resolucionIntervalo)]);
    printPlot()
end
## ==================================

## Finalmente, creamos una gráfica  actualizables con la función "printPlot"
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
  # Como no podemos hacer una varilla continua, la cuantizamos en cachitos, cuyo número es establecido con resolucionVarilla.
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

  ESubplot = subplot(1, 1, 1);
  EPlot = plot(x, E, "r")
  xlabel("\nx (m)", "FontWeight", "bold", "FontAngle", "italic", "FontSize", 15) %Aplicar estilo en label X
  ylabel("E (N/C)\n\n", "FontWeight", "bold", "FontAngle", "italic", "FontSize", 15) %Aplicar estilo en label Y
  title("Campo eléctrico de una varilla cargada", "FontWeight", "bold", "FontAngle", "italic", "FontSize", 15) %Aplicar estilo en título

  set(ESubplot, "position", [0.1 0.3 0.8 0.6])
  set(EPlot, "linewidth", 2)
end

printPlot()
