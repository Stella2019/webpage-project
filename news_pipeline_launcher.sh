
#!/bin/bash
service redis_6379 start
service mongod start

pip install -r requirements.txt

pip install newspaper --ignore-installed six --ignore installed lxml

cd news_topic_modeling_service/server
python server.py &

cd ../../news_pipeline
python news_monitor.py &
python news_fetcher.py &
python news_deduper.py &

echo "=================================================="
read -p "PRESS [ENTER] TO TERMINATE PROCESSES." PRESSKEY

kill $(jobs -p)