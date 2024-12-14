from utils import * 
from logging_config import setup_logging
import logging



def etl():
    # download s3 data
    download_s3_bucket_directory(bucket_name = 'udacity-dend', prefix_name = 'song-data', max_download_number = 20) 
    download_s3_bucket_directory(bucket_name = 'udacity-dend', prefix_name = 'log-data',  max_download_number = 5)


    # staging area

if __name__ == "__main__":
    setup_logging()
    logging.getLogger(__name__).info("ETL Started")
    etl()