FROM pytorch/pytorch:1.12.1-cuda11.3-cudnn8-runtime

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get install -y \
    git \
    wget \
    unzip \
    vim


COPY requirements.txt ./requirements.txt
RUN pip install -r requirements.txt

RUN rm -rf /var/lib/apt/lists/*
ARG UID
ARG GID
ARG USER
ARG GROUP

RUN groupadd -g $GID $GROUP
RUN useradd -r -s /bin/false -g $GROUP -G sudo -u $UID $USER
RUN mkdir /home/$USER
RUN chmod -R 755 /home/$USER
RUN chown -R $USER:$USER /home/$USER

USER $USER
CMD /bin/bash



