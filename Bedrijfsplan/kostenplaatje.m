%Kostenplaatje van de paal
clear all; close all;

nb_panelen = 2;
paal_kostprijs = kostprijs();

%Schattingen
nb_palen =      [5,10,25,35,40,43,45,47,49,49,50];
%nb_palen =      [5,7,10,15,25,35,42,46,48,49,50];
levensduur =    10;     %jaar
opbrengst =     200;    %kWh/jaar
prijs_kwh =     0.23;   %euro/kWh
vernieuw_kosten=paal_kostprijs/2;  %euro
winstmarge =    20;     %%
jaar =          0:1:10;
max_nb_palen =  50; 
saturatietijd = 5;      %jaar
max_users =     10;
users = [2.5, 2.8, 3.2, 3.8, 4.5, 5.5, 6.5, 7.2, 7.7, 8, 8.2];  %max_users ./ (1 + exp(-0.2*(jaar - saturatietijd)));
bedrijven = users / 10;
uren_customerservice = nb_palen./25*40*4; %25 palen per customerservice persoon
uren_onderhoud = nb_palen/3; %1 uur per paal per maand
uren_sales = nb_palen./10*40*4; %5 palen per sales persoon


%Maandelijkse kosten
kosten_reclame =       500;           %euro
kosten_onderhoud =     20 * nb_palen; %euro
kosten_internet =      5 * nb_palen;  %euro
kosten_nuts =          300;           %euro
kosten_afschrijvingen = vernieuw_kosten/levensduur/12*nb_palen;%euro
kosten_kantoor =       1000;           %euro
kosten_bedrijfplaatsen = paal_kostprijs * bedrijven;%euro
%reclamebelasting = undefined;
%overige_belastingen = undefined;
kosten_personeel =     (uren_customerservice+uren_onderhoud+uren_sales)*10; %euro

kosten = kosten_reclame + kosten_onderhoud + kosten_internet + kosten_nuts + kosten_afschrijvingen ...
    + kosten_kantoor + kosten_bedrijfplaatsen + kosten_personeel;

%Afgeleide waarden
users_total = users .* nb_palen * 30;                   %per maand
stroomopbrengst = nb_panelen * nb_palen * opbrengst;    %kWh/jaar
stroomopbrengst_euro = stroomopbrengst * prijs_kwh;     %euro/jaar
ladingen = users_total/nb_palen/30*0.9;                 %ladingen/dag
kwh_nodig = nb_palen*0.5*ladingen*365;                  %kWh/jaar
netto_stroomopbrengst_euro = (stroomopbrengst - kwh_nodig) * prijs_kwh;

verkoopkosten = 200;
onderhoudskosten = 0;
prijs = (paal_kostprijs + verkoopkosten + onderhoudskosten) * (1 + winstmarge/100);
prijs_incl = prijs * 1.21;

%Inkomsten
inkomsten_videos = users_total*0.5;
inkomsten_lokaal = 8*nb_palen*30;
inkomsten_punten = users_total*0.5;
inkomsten_reclame = users_total*0.5;
inkomsten_boetes = users_total/10*0.5*5;
stroom_zonnep = netto_stroomopbrengst_euro/12;
palen_bedrijven = bedrijven*prijs;
inkomsten = inkomsten_videos + inkomsten_lokaal + inkomsten_punten + inkomsten_reclame + stroom_zonnep + ...
    palen_bedrijven + inkomsten_boetes;

netto = (inkomsten - kosten)*12;

for(j=1:1:11)
    if (j==1)
        nieuwe_palen(j) = nb_palen(j);
    else
        nieuwe_palen(j) = nb_palen(j)-nb_palen(j-1);
    end
end

kosten_nieuwe_palen = nieuwe_palen * paal_kostprijs;

result = netto(1)-kosten_nieuwe_palen(1);
for(j=1:1:10)
   result(j+1)=result(j)+netto(j+1)-kosten_nieuwe_palen(j+1); 
end

plot(jaar,result,jaar,zeros(11));
xlabel('jaar');
ylabel('kas [euro]');
figure();
plot(jaar,users,jaar,zeros(11));
xlabel('jaar');
ylabel('gebruikers per paal');
figure();
plot(jaar,nb_palen,jaar,nieuwe_palen,jaar,zeros(11));
xlabel('jaar');
ylabel('aantal palen');