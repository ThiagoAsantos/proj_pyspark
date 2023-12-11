# Use a imagem base
FROM ubuntu:23.10

# Atualize os pacotes do sistema
RUN apt-get update && apt-get upgrade -y

# Crie o diretório /data no diretório raiz
RUN mkdir /data

# CMD ou ENTRYPOINT para definir um comando padrão ao iniciar o contêiner
#CMD ["tail", "-f", "/dev/null"]
