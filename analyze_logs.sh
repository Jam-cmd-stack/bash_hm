#!/bin/bash

# Создаем файл с логами
cat <<EOL > access.log
192.168.1.1 - - [28/Jul/2024:12:34:56 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.2 - - [28/Jul/2024:12:35:56 +0000] "POST /login HTTP/1.1" 200 567 
192.168.1.3 - - [28/Jul/2024:12:36:56 +0000] "GET /home HTTP/1.1" 404 890
192.168.1.1 - - [28/Jul/2024:12:37:56 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.4 - - [28/Jul/2024:12:38:56 +0000] "GET /about HTTP/1.1" 200 432
192.168.1.2 - - [28/Jul/2024:12:39:56 +0000] "GET /index.html HTTP/1.1" 200 1234
EOL

# 1. Подсчет общего количества запросов
total_requests=$(cat access.log | wc -l)
echo "Общее количество запросов: $total_requests"

# 2. Подсчет количества уникальных IP-адресов 
unique_ips=$(cat access.log | awk '{print $1}' | sort -u | wc -l)
echo "Количество уникальных IP-адресов: $unique_ips"

# 3. Подсчет количества запросов 
request_methods=$(cat access.log | awk '{print $6}' | sort | uniq -c)
echo "Количество запросов по методам:"
echo "$request_methods"

# 4. Поиск самого популярного URL
popular_url=$(cat access.log | awk '{print $7}' | sort | uniq -c | sort -nr | head -1 | awk '{print $2}')
echo "Самый популярный URL: $popular_url"

# 5. Создание отчета в файле report.txt
cat <<EOL > report.txt
Общее количество запросов: $total_requests
Количество уникальных IP-адресов: $unique_ips
Количество запросов по методам:
$request_methods
Самый популярный URL: $popular_url
EOL

echo "Отчет сохранен в файл report.txt"
