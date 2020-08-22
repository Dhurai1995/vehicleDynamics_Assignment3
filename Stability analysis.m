psydotpeak = min(r*180/pi);
r = x(:,3);
stime = 1/strFreq;
t0plus = dwell+stime+tStart;
t0plus1 = (t0plus+1)/sampleTime;
psyt0plus1 = r(round(t0plus1))*180/pi;
% to find YRR1 
YRR1 = 100*psyt0plus1/psydotpeak
%to find YRR2 
t0plus175 = (t0plus+1.75)/sampleTime;
psy0plus175 = r(round(t0plus175))*180/pi;
YRR2 = 100*psy0plus175/psydotpeak
% to find disp
tlateral = tStart+1.07;
lateraldisp = abs(Y(round(tlateral/sampleTime)))

