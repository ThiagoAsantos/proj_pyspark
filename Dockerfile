# Use a imagem base
FROM ubuntu:23.10

# Atualize os pacotes do sistema
RUN apt-get update && apt-get upgrade -y

# Instale as dependências necessárias
RUN apt-get install -y tar

# Crie uma pasta no conteiner
RUN mkdir /opt/jdk

# Copie o arquivo tar.gz do Java para o conteiner (assumindo que o arquivo está no mesmo diretório do Dockerfile)
COPY ./data/jdk-17_linux-x64_bin.tar.gz /opt/

# Descompacte o arquivo tar.gz do Java e renomeie a pasta para "jdk"
RUN tar -zxvf /opt/jdk-17_linux-x64_bin.tar.gz --strip-components=1 -C /opt/jdk \
    && rm /opt/jdk-17_linux-x64_bin.tar.gz

# Configure as variáveis de ambiente do Java diretamente
ENV JAVA_HOME /opt/jdk
ENV PATH $JAVA_HOME/bin:$PATH

# CMD para iniciar o shell bash
CMD ["/bin/bash"]
