FROM python:3.10.14-slim-bookworm
WORKDIR /code

COPY ./app/rag-tutorial-v2/requirements.txt /code/requirements.txt

RUN apt update && apt upgrade -y
RUN apt install -y openssh-server

# Environment configure
RUN apt install -y curl wget zsh git vim tmux htop btop
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN chsh -s $(which zsh)

# Install libraries
RUN pip install --upgrade pip
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Configure SSH
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]