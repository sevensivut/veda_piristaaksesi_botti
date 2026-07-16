# Flovi-botin asennusohje

Tämä pieni ohjelma painaa automaattisesti Flovi-sovelluksen "päivitä"-nappia (nuoli alas kahdesti) tasaisin väliajoin ja ilmoittaa sinulle, kun jotain muuttuu. Ei vaadi mitään ohjelmointitaitoa — riittää, että seuraat nämä vaiheet järjestyksessä.

## Mitä tarvitset

- Mac-tietokone
- Flovi asennettuna (App Storesta)
- Koodinpätkä, jonka sait minulta (tiedosto `pull_to_refresh_watch.lua`)

---

## Vaihe 0: Ota käyttöön asetus Flovi-sovelluksessa

Ennen kuin botti toimii, Flovista pitää käydä päälle laittamassa yksi asetus.

1. Avaa **Flovi**
2. Mene **Asetukset**-valikkoon
3. Etsi kohta **"Touch alternatives"** — suomenkielistä nimeä en ole täysin varma, mutta se voi olla jotain tyyliin **"Kosketuksen vaihtoehdot"** tai **"Kosketustoiminnot"**. Jos et löydä sitä heti, selaa Asetukset-valikko läpi ja etsi mitä tahansa kohtaa, jossa mainitaan "kosketus" tai "vaihtoehdot"
4. Kytke se **päälle (On)**

Tämä asetus mahdollistaa sen, että nuolinäppäimen painallus toimii samoin kuin sormella pyyhkäisy alaspäin (päivitys). Ilman tätä botti ei saa Flovia päivittymään.

---

## Vaihe 1: Lataa ja asenna Hammerspoon

Hammerspoon on ilmainen apuohjelma, joka tekee automaation mahdolliseksi.

1. Mene osoitteeseen **hammerspoon.org**
2. Lataa uusin versio
3. Kun lataus on valmis, raahaa Hammerspoon-kuvake **Ohjelmat**-kansioon (samalla tavalla kuin muutkin sovellukset asennetaan)
4. Avaa Hammerspoon Ohjelmat-kansiosta (tuplaklikkaa)

Yläpalkkiin (näytön yläreunaan) pitäisi ilmestyä pieni Hammerspoon-kuvake.

---

## Vaihe 2: Anna tarvittava lupa

1. Avaa **Järjestelmäasetukset** (omenavalikko vasemmassa yläkulmassa → Järjestelmäasetukset)
2. Mene kohtaan **Tietosuoja ja turvallisuus**
3. Etsi listasta **Esteettömyys** (englanniksi "Accessibility") ja klikkaa sitä
4. Etsi listasta **Hammerspoon** ja laita sen vieressä oleva kytkin päälle
5. Jos Mac kysyy salasanaa tai sormenjälkeä, vahvista

Tämä lupa tarvitaan, jotta Hammerspoon voi painaa nappeja puolestasi.

---

## Vaihe 3: Liitä koodi paikoilleen

1. Klikkaa Hammerspoon-kuvaketta yläpalkissa
2. Valitse **"Open Config"**
3. TextEdit avautuu automaattisesti oikean tiedoston kanssa
4. Kopioi minulta saamasi koodi **kokonaan** ja liitä se tiedostoon (korvaa mahdollinen vanha sisältö)
5. Tallenna tiedosto (**Cmd + S**)

---

## Vaihe 4: Käynnistä botti

1. Klikkaa Hammerspoon-kuvaketta yläpalkissa uudestaan
2. Valitse **"Reload Config"** (tai paina pikanäppäintä **Cmd + Shift + R**)

Jos mitään virheilmoitusta ei tule esiin, kaikki on valmista!

---

## Näin käytät sitä

Pidä Flovi auki koko ajan seurannan aikana. Käytä näitä näppäinyhdistelmiä:

| Näppäimet | Mitä tapahtuu |
|---|---|
| **Cmd + Alt + R** | Aloita seuranta |
| **Cmd + Alt + S** | Lopeta seuranta |
| **Cmd + Alt + F** | Vaihda tila: pysähtyykö ensimmäisestä muutoksesta, vai jatkaako ilmoittaen aina uudesta muutoksesta |
| **Cmd + Shift + R** (Hammerspoonin ikkunassa) | Lataa asetukset uudelleen — tarvitaan vain, jos koodia muutetaan myöhemmin |

Kun muutos havaitaan, kuulet äänimerkin ja saat ilmoituksen ruudulle.

---

## Muista

- **Tietokone ei saa mennä lepotilaan** seurannan aikana — botti ei toimi silloin. Näytönsäästäjä ei haittaa, mutta lepotila (kansi kiinni, tai näyttö sammuu pitkän ajan jälkeen) pysäyttää sen.
- Flovin täytyy pysyä auki.
- Jos jokin ei toimi, ota yhteyttä minuun — kerro mitä yritit tehdä ja mitä tapahtui.
