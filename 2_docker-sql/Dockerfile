FROM python:3.9

RUN pip install pandas

WORKDIR /app
# copy the data file to the container
# format: copy localfile_name destination_name
COPY pipeline.py pipeline.py

ENTRYPOINT [ "python", "pipeline.py" ]