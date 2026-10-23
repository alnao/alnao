*perchè non si smette mai di imparare*

Linux Foundation certification
- pws: cartella corrente
- stat nomefile: statistiche
- file nomefile: determina il tipo di un file
- wc -l : conta righe                       tree oppure ls -R
- wc -l < file.txt
- sort < unsorted.txt > sorted.txt
- ls /nonexistent 2> errors.txt             redirige stderr
- find / -name "*.log" 2> /dev/null         redirige stderr
- command &> output.txt                     redirige sia stdout che stderr
- ls -l | grep ".txt"                       pipe passa stdout come stdin al comando successivo
- find ~ -name "*.txt"                      Trova tutti i file .txt nella home
- find / -type f -size +100M 2>/dev/null    trova file più grandi di 100MB
- find ~/documents -name "*.pdf" -exec ls -lh {} \;         esegue un comando su ogni file trovato
- locate "*.conf" | grep nginx              locale veloce ma deve essere aggiornato apt install mlocate
- find . -name "*.txt" | xargs grep "pattern" xargs=costruisce ed esegue comandi da input (comando non accetta input da pipe)
- useradd -m -u 1500 -g 1500 charlie        Crea utente con UID e GID specifici
- usermod -s /bin/zsh alice                 Cambia shell
- usermod -aG docker,www-data bob           Aggiungi utente a gruppo supplementare
- gpasswd -a alice developers               Aggiungi utente a gruppo
- who -a                                    Utenti attualmente loggati - alternativa al comando `w`
- `adduser` è uno script interattivo (Debian/Ubuntu), `useradd` è il comando low-level universale.
- `getent group groupname` o `grep groupname /etc/group` Come vedere tutti i membri di un gruppo?**  
- ps 
- ps aux                                    elenco processi
- top/htop                                  M - ordina per memoria
- nice -n 10 comando                        Avvia con priorità bassa (nice value 10)
- renice 5 -p PID                           Cambia priorità processo esistente -20 (max priority) a 19 (min priority)
- job                                       mostra in sfondo, fg %1 riprende dal background, fg riporta in foreground
- cat /proc/5668/cmdline
- lsof -p 5668                              file aperti da un processo!
- systemctl list-units --type=service       tutti i servizi
- systemctl list-dependencies nginx         sudo systemctl daemon-reload
- journalctl -u kubelet
- journalctl -b -1                          log del boot precedente     journalctl --since "2024-01-15" --until "2024-01-16"
- 


