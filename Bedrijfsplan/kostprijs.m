function [ totaal ] = kostprijs()
%KOSTPRIJS functie
%   Berekening van de kostprijs van de paal
zonnepanelen =      2*180;
powerelectronics =  1*1500;
microcontroller =   1*100;
hotspot =           1*100;
batterijen =        1*500;
fundering =         1*1000;
materiaal =         1*2000;
reclameschermen =   2*500;
installatiekosten = 1*1500;

totaal = zonnepanelen + powerelectronics + microcontroller + hotspot... 
    + batterijen + fundering + materiaal + reclameschermen ...
    + installatiekosten;

end

