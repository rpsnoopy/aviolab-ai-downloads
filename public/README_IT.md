# Script di Installazione Agenti TTR-SUITE

## Panoramica
Questo script ti aiuta a installare automaticamente i file DLL degli agenti nella tua installazione TTR-SUITE. Può gestire sia file DLL singoli che archivi ZIP contenenti file agente.

## Prerequisiti
- TTR-SUITE deve essere installato in `C:\TTR-SUITE\`
- Windows PowerShell (per l'estrazione ZIP)
- Potrebbero essere necessari privilegi amministrativi

## Come Utilizzarlo

1. **Scarica** il pacchetto di installazione contenente:
   - `install-agents.bat` - Script di installazione principale
   - `README_EN.md` - Documentazione in inglese
   - `README_IT.md` - Questa documentazione italiana

2. **Estrai** il pacchetto in qualsiasi posizione del tuo computer

3. **Prepara i tuoi file agente** in uno di questi formati:
   - **Opzione A**: Directory contenente file `.dll` singoli
   - **Opzione B**: Directory contenente archivi `.zip` con file DLL all'interno

4. **Esegui lo script**:
   - Doppio clic su `install-agents.bat`
   - Oppure esegui dal prompt dei comandi: `install-agents.bat`

5. **Segui le istruzioni**:
   - Inserisci il percorso della directory contenente i file agente
   - Rivedi il riepilogo dell'installazione
   - Conferma per procedere con l'installazione

## Cosa Fa lo Script

### Se vengono trovati file DLL direttamente:
- Copia tutti i file `.dll` in `C:\TTR-SUITE\AppData\AgentCodes\`
- Verifica che ogni file sia stato copiato correttamente

### Se vengono trovati solo file ZIP:
- Estrae tutti i file ZIP in una directory temporanea
- Cerca ricorsivamente i file `.dll` nel contenuto estratto
- Copia tutti i file DLL trovati nella destinazione
- Pulisce automaticamente i file temporanei

## Directory di Installazione
I file agente vengono installati in:
```
C:\TTR-SUITE\AppData\AgentCodes\
```

Questa directory verrà creata automaticamente se non esiste.

## Gestione Errori
- Valida l'installazione TTR-SUITE prima di procedere
- Controlla i permessi dei file e lo spazio su disco
- Fornisce messaggi di errore dettagliati per la risoluzione dei problemi
- Riporta le operazioni sui file riuscite e fallite

## Risoluzione Problemi

**"TTR-SUITE not found"**
- Assicurati che TTR-SUITE sia installato in `C:\TTR-SUITE\`
- Verifica che l'installazione sia completa

**"Failed to copy files"**
- Esegui lo script come Amministratore
- Controlla lo spazio disco disponibile
- Verifica che i file sorgente non siano corrotti

**"No DLL files found in ZIP"**
- Assicurati che i file ZIP contengano file DLL agente validi
- Controlla che i file ZIP non siano corrotti

## Supporto
Per supporto tecnico, contatta: info@aviolab.ai

## Versione
Versione Script: 1.0
Compatibile con: TTR-SUITE 3.2+

---
© 2025 Aviolab AI - Utilità di Installazione Agenti