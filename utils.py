import boto3
from botocore import UNSIGNED
from botocore.config import Config
import os
import logging

logger = logging.getLogger(__name__)


def download_s3_bucket_directory(bucket_name, prefix_name, max_download_number):
    s3 = boto3.client('s3', config=Config(signature_version=UNSIGNED))

    logger.info(f"utils -> download_s3_bucket_directory -> {prefix_name} -> getting bucket response")

    response = s3.list_objects_v2(Bucket=bucket_name, Prefix=prefix_name)

    logger.info(f"utils -> download_s3_bucket_directory -> {prefix_name} -> got bucket response")

    downloaded_files_lst = []
    if prefix_name in os.listdir(os.getcwd()):
        downloaded_files_lst = os.listdir(os.path.join(os.getcwd(), prefix_name))

    

    if 'Contents' in response:
        download_obj_counter = 0
        for obj in response['Contents']:
            if obj['Key'].replace('/', '-') in downloaded_files_lst:
                logger.info(f"utils -> download_s3_bucket_directory -> {prefix_name} -> skipping downloading {obj['Key']} already exists")

            elif 'json' in obj['Key']:
                local_file_path = os.path.join(prefix_name, obj['Key'].replace('/', '-'))
                os.makedirs(os.path.join(os.getcwd(), os.path.dirname(local_file_path)), exist_ok=True)
                
                s3.download_file(bucket_name, obj['Key'], local_file_path)
                logger.info(f"utils -> download_s3_bucket_directory -> {prefix_name} -> successfully downloaded {obj['Key']}")
                download_obj_counter +=1
            
            if download_obj_counter >= max_download_number:
                logger.info(f"utils -> download_s3_bucket_directory -> {prefix_name} -> stopping download")
                logger.info(f"utils -> download_s3_bucket_directory -> {prefix_name} -> stopping download - reached max number of downloads for this iteration for this prefix")
                break
