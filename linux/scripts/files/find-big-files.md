
### Encontrar arquivos grandes

find /var -type d -print0 | xargs -0 du -sh

### find the top 10 largest directories on your Linux system:
du -h / | sort -hr | head -n 10

### If you want to find directories that are larger than a certain size
find / -type d -size +1G
