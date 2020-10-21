FROM r-base:latest
RUN /bin/sh -c apt-get update && apt-get install -y libpq-dev build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev && apt clean cache 
