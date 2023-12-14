# Use a imagem base
FROM ubuntu:23.10

# Atualize os pacotes do sistema
RUN apt-get update && apt-get upgrade -y

# Instale as dependências necessárias, incluindo o Python e o pip para Python
RUN apt-get install -y tar python3 python3-pip

# Crie uma pasta no contêiner
RUN mkdir /opt/jdk

RUN mkdir /projetos

RUN mkdir /projetos/jars

RUN mkdir /projetos/tmp

# Copie o arquivo tar.gz do Java para o contêiner (assumindo que o arquivo está no mesmo diretório do Dockerfile)
COPY ./jars/jdk-17_linux-x64_bin.tar.gz /opt/

COPY ./jars/postgresql-42.7.1.jar /projetos/jars/

# Descompacte o arquivo tar.gz do Java e renomeie a pasta para "jdk"
RUN tar -zxvf /opt/jdk-17_linux-x64_bin.tar.gz --strip-components=1 -C /opt/jdk \
    && rm /opt/jdk-17_linux-x64_bin.tar.gz

# Configure as variáveis de ambiente do Java diretamente
ENV JAVA_HOME /opt/jdk
ENV PATH $JAVA_HOME/bin:$PATH

# Instale o pacote python3-venv para obter o módulo venv
RUN apt-get install -y python3-venv

# Crie um ambiente virtual
RUN python3 -m venv /projetos

# Defina o ambiente virtual como o ambiente de trabalho padrão
WORKDIR /projetos

# Instale o PySpark dentro do ambiente virtual
RUN /projetos/bin/pip install pyspark==3.5.0

# CMD para iniciar o PySpark automaticamente
# CMD ["/projetos/bin/bash", "-c", "source bin/activate && pyspark"]