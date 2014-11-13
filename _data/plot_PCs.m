figure
hold on

subplot(3,1,1)
pcolor(fftshift(xx{2}),fftshift(xx{1}),fftshift(real(PC1)));
hc=colorbar; shading flat; axis equal;

subplot(3,1,2)
pcolor(fftshift(xx{2}),fftshift(xx{1}),fftshift(real(PC2)));
hc=colorbar; shading flat; axis equal;

subplot(3,1,3)
pcolor(fftshift(xx{2}),fftshift(xx{1}),fftshift(real(PC3)));
hc=colorbar; shading flat; axis equal;

