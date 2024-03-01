FROM python:3
RUN apt-get update && apt-get install -y ca-certificates curl gnupg
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
ARG NODE_MAJOR=20

RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update && apt-get install nodejs -y
RUN apt-get install shellcheck -y
WORKDIR /home
RUN git clone https://github.com/sveinpj/tinypilot
WORKDIR /home/tinypilot
RUN pip install -r requirements.txt
RUN pip install -r dev_requirements.txt
RUN npm install prettier
# RUN ./dev-scripts/build

EXPOSE 8000
ENV PORT=8000

CMD ["python", "/home/tinypilot/app/main.py"]
