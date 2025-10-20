FROM python:3.10.8-slim

RUN apt-get -y update;
RUN apt-get install --no-install-recommends -y python3-dev pip git ffmpeg libsm6 libxext6;
RUN pip install --upgrade pip;

COPY . Octopii

WORKDIR Octopii
RUN pip install -r requirements.txt;
RUN apt-get install -y tesseract-ocr;
RUN python -m spacy download en_core_web_sm;

RUN python -c "import nltk; nltk.download('punkt_tab'); nltk.download('averaged_perceptron_tagger_eng'); nltk.download('maxent_ne_chunker_tab'); nltk.download('stopwords'); nltk.download('words')"

ENTRYPOINT ["python3", "octopii.py", "/pii"]
