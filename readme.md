# Getting and Cleaning Data - Kursprojekt
run_analysis.R verarbeitet die UCI HAR-Daten in 5 Schritten:
1. Train- und Testdaten zusammenführen
2. Extraktion der mean()- und std()-Messwerte
3. Aktivitätsnamen zuordnen
4. Variablennamen bereinigen
5. Tidy Dataset mit Mittelwerten je Aktivität + Proband erstellen
Ausgabe: tidy_dataset.txt (180 Zeilen × 68 Spalten)