[tf,f] = tfestimate(deltaf,r,[],[],[],100);
gain = abs(tf);
figure()
semilogx(f,gain)