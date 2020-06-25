ALTER TABLE pracownicy MODIFY telefon varchar(20);
UPDATE ksiegowosc.pracownicy SET telefon=CONCAT("(+48)",telefon)

SET telefon = SUBSTRING(telefon,1,5) || ' ' || SUBSTRING(telefon,6,3) || '-' || SUBSTRING(telefon,9,3) || '-' || SUBSTRING(telefon,12,3);

SELECT id_pracownika, UPPER(imie) AS IMIE, UPPER(nazwisko) AS NAZWISKO, UPPER(adres) AS ADRES, telefon FROM ksiegowosc.pracownicy
WHERE LENGTH(nazwisko) = (SELECT MAX(LENGTH(nazwisko)) FROM ksiegowosc.pracownicy);

SELECT KP.*, MD5('kwota') AS md5_pensja 
FROM ksiegowosc.wynagrodzenie KW, ksiegowosc.pracownicy KP
WHERE KW.id_pracownika = KP.id_pracownika 

SELECT imie, nazwisko, pensja.kwota AS pensja, premia.kwota AS premia FROM ksiegowosc.wynagrodzenie 
LEFT JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
LEFT JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
LEFT JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii;

SELECT  KP.* , PENSJA.kwota AS pensja, PREMIA.kwota AS premia
FROM ksiegowosc.pracownicy KP
LEFT JOIN ksiegowosc.wynagrodzenie KW
ON KW.id_pracownika = KP.id_pracownika 
LEFT JOIN ksiegowosc.pensja PENSJA
ON KW.id_pensji = PENSJA.id_pensji  
LEFT JOIN ksiegowosc.premia PREMIA
ON KW.id_premii = PREMIA.id_premii 

SELECT 'Pracownik ' || kp.imie || ' ' || kp.nazwisko 
|| ' w dniu ' || kg.dat
|| ' otrzymał pensje całkowitą na kwotę ' || kpen.kwota + kpr.kwota 
|| ' gdzie wynagrodzenie zasadnicze wynosiło: '|| kpen.kwota || ',a premia: ' || kpr.kwota || ', nadgodziny: ' || '0 zł' AS raport
FROM ksiegowosc.pracownicy kp
JOIN ksiegowosc.wynagrodzenia kw ON kw.id_pracownika = kp.id_pracownika 
JOIN ksiegowosc.pensja kpen ON kpen.id_pensji = kw.id_pensji 
JOIN ksiegowosc.premia kpr ON kpr.id_premii = kw.id_premii 
JOIN ksiegowosc.godziny kg ON kp.id_pracownika = kp.id_pracownika;
