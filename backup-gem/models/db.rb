# encoding: utf-8
# Backup model

Backup::Model.new(:db, "Back up postgres database") do
    split_into_chunks_of 1024

    database PostgreSQL do |db|
      db.name = 'postgres'
      db.username = 'postgres'
      db.password = 'postgres'
      db.host = '127.0.0.1'
      db.port = '5432'
    end

    compress_with Gzip

    store_with S3 do |s3|
      s3.access_key_id = 'S3_ACCESS_KEY_ID'
      s3.secret_access_key = 'S3_ACCESS_SECRET_KEY'
      s3.bucket = 'BUCKET_NAME'
      s3.fog_options = {
        :host   => 'minio.mydomain.org',
        :scheme => 'https',
        :port   => 9000,
        :path_style => true
      }
    end
end

