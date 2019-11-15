for i = 1:5
    figure;
    bodemag(get_stage_tf(i));
    title('');
    grid on;
    xlabel('Frecuencia');
    h = gcr;
    setoptions(h,'FreqUnits','Hz');
    saveas(gca, strcat('../Informe/imagenes/bode_etapa_',sprintf('%d',i),'.png'));
end
