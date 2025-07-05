# Release Management Guide

Questa guida spiega come gestire le release di file grandi (>100MB) e rimuovere Git LFS dal repository.

## 📦 Creare Nuove Release per File Grandi

### Quando Usare le Release
- File **maggiori di 100MB** (limite GitHub raw download)
- Versioni stabili di software/tools
- File che cambiano raramente

### Processo di Release

#### 1. Preparare il File
```bash
# Assicurati che il file sia pronto e testato
# Esempio: TTR-SUITE.zip, TTR-PROBE.zip, etc.
```

#### 2. Creare la Release su GitHub
```bash
# Opzione A: Via Web Interface
1. Vai su GitHub → Releases
2. Click "Create a new release"
3. Tag version: es. "v.3.1", "v.4.0"
4. Title: "Release 3.1" o descrittivo
5. Description: changelog/note
6. Attach files: trascina i file ZIP
7. Publish release

# Opzione B: Via GitHub CLI
gh release create v.3.1 TTR-SUITE.zip TTR-PROBE.zip --title "Release 3.1" --notes "Aggiornamento tools"
```

#### 3. Ottenere il Link di Download
Formato: `https://github.com/rpsnoopy/aviolab-ai-downloads/releases/download/TAG/FILENAME.zip`

Esempio:
```
https://github.com/rpsnoopy/aviolab-ai-downloads/releases/download/v.3.1/TTR-SUITE.zip
```

#### 4. Aggiornare il Sito Web
Nel file `js/downloads.js` del sito:
```javascript
{
    name: 'TTR-SUITE',
    description: 'Complete TTR suite package',
    icon: 'fas fa-box',
    file: 'https://github.com/rpsnoopy/aviolab-ai-downloads/releases/download/v.3.1/TTR-SUITE.zip'
}
```

#### 5. Documentare nel README
Aggiorna il README.md con i nuovi link se necessario.

## 🗑️ Rimuovere Git LFS dal Repository

### Perché Rimuovere Git LFS
- Costi di storage
- Complessità di gestione
- File grandi gestiti via release

### Processo di Rimozione

#### 1. Backup del Repository
```bash
# Clona una copia di backup
git clone https://github.com/rpsnoopy/aviolab-ai-downloads.git backup-repo
```

#### 2. Rimuovere Git LFS Localmente
```bash
# Disinstalla Git LFS per questo repo
git lfs uninstall

# Rimuovi i file tracked da LFS
git lfs untrack "*.zip"

# Rimuovi .gitattributes se vuoto
rm .gitattributes
# oppure modifica per rimuovere le regole LFS
```

#### 3. Convertire File LFS a File Normali
```bash
# Migra i file da LFS a repository normale
git lfs migrate import --everything --include="*.zip"
git lfs migrate export --everything --include="*.zip"
```

#### 4. Rimuovere File ZIP dal Repository
```bash
# Rimuovi i file ZIP dal tracking (saranno serviti via release)
git rm public/TTR-SUITE.zip
git rm public/TTR-PROBE.zip
git rm clients/*/TTR-PROBE.zip

# Commit le modifiche
git commit -m "Remove large ZIP files - now served via GitHub releases"
```

#### 5. Pulire la Storia Git (ATTENZIONE!)
```bash
# ATTENZIONE: Questo riscrive la storia Git
# Rimuove completamente i file grandi dalla storia
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch *.zip' --prune-empty --tag-name-filter cat -- --all

# Pulisci i riferimenti
git for-each-ref --format='delete %(refname)' refs/original | git update-ref --stdin
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

#### 6. Force Push (ATTENZIONE!)
```bash
# ATTENZIONE: Questo sovrascrive la storia remota
git push --force --all
git push --force --tags
```

### ⚠️ Importante - Dopo la Rimozione LFS

1. **Aggiorna README.md** per riflettere che i file grandi sono serviti via release
2. **Aggiorna il sito web** per puntare alle release invece che ai raw files
3. **Comunica il cambiamento** a chi usa i link diretti
4. **Testa tutti i download** per verificare che funzionino

## 🔄 Workflow Consigliato

### Per File Piccoli (<100MB)
1. Commit normale nel repository
2. Link raw: `https://github.com/rpsnoopy/aviolab-ai-downloads/raw/main/path/file.zip`

### Per File Grandi (>100MB)
1. Crea release su GitHub
2. Link release: `https://github.com/rpsnoopy/aviolab-ai-downloads/releases/download/tag/file.zip`
3. Aggiorna sito web con il nuovo link

## 📋 Checklist Release

- [ ] File testato e pronto
- [ ] Release creata su GitHub
- [ ] Link di download verificato
- [ ] Sito web aggiornato
- [ ] README aggiornato se necessario
- [ ] Commit e push delle modifiche
- [ ] Test download dal sito web

## 🆘 Troubleshooting

### "File too large" durante download
- Verifica che il file sia in una release, non raw
- Controlla che il link sia corretto
- Prova download diretto dalla pagina release

### Git LFS errori
- Verifica installazione: `git lfs version`
- Reinstalla se necessario: `git lfs install`
- Per disabilitare: `git lfs uninstall`

### Link non funzionanti
- Controlla che la release sia pubblica
- Verifica che il tag sia corretto
- Testa il link direttamente nel browser

---
**© 2025 Aviolab AI - Release Management Guide**