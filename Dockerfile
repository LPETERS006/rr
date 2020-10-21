FROM r-base:latest
RUN /bin/sh -c apt-get update && apt-get upgrade -y && apt clean cache \
  && apt-get install -t unstable -y --no-install-recommends libpq-dev build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev \
  && mkdir -p /opt/software/setup/R/ /opt/software/R/; \	
  { echo 'install.packages("RPostgreSQL")';
    echo 'install.packages("devtools")';
    echo 'install.packages("config")';
    echo 'install.packages("log4r")';
    echo 'install.packages("psychrolib")';
    echo 'install.packages("Rserve")';
    echo ''; 		
    echo 'require(devtools)'; 		
    echo 'install_version("reshape", version="0.8.6")'; 		
    echo 'install_version("lpSolveAPI", version="5.5.2.0-17")'; 		
    echo ''; 		
    echo 'setwd("/opt/software/R")'; 		
    echo ''; 		
    echo 'library(Rserve)';
    echo 'Rserve(args="--no-save")';
    echo ''; 
  } > /opt/software/setup/R/install_packages.R \
  && Rscript /opt/software/setup/R/install_packages.R \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds && rm -rf /var/lib/apt/lists/* /opt/software/setup/R/*
  EXPOSE 6311
  ENTRYPOINT ["/bin/sh" "-c" "R -e \"Rserve::run.Rserve(remote=TRUE)\""]
