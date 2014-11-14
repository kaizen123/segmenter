function h = PlotVectorStats( L, stats );

pcolor( L );
shading flat
axis equal
colormap( rand(100,3));

hold on

h = errorbarxy( stats.center( :, 2), stats.center( :, 1), ...
            stats.std( :, 2), stats.std( :, 1));
        
set( h.hMain, ...
    'LineStyle', 'none' )
hold off
figure(gcf)