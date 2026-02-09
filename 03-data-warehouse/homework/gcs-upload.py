from google.cloud import storage
import requests

client = storage.Client()
#bucket = client.create_bucket('dez-bigquery-sandbox')
bucket = client.bucket('dez-bigquery-sandbox')

for i in range(5,7):
    blob_name = f"yellow_tripdata_2024-{i:02d}"

    url = "https://d37ci6vzurychx.cloudfront.net/trip-data/"+blob_name+".parquet"

    # Stream directly to GCS
    blob = bucket.blob(f'data/{blob_name}.parquet')

    response = requests.get(url, stream=True)
    blob.upload_from_file(response.raw, timeout=300)

    print(f"File uploaded to gs://your-bucket-name/data/{blob_name}.parquet")
