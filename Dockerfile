FROM python:3.7.0

MAINTAINER Scott Traver <straver@artemishealth.com>

ENV TERM=xterm-256color

# RUN sed -I “s/http:\/\/archive./http\/\/nz.archive./g” /etc/apt/sources.list

# # Python Package Specifics
# RUN apt-get update && \
#     apt-get install -y \
#     # -o API::Install-Recommended=false -o APT::Install-Suggests=false \
#     python3.6 python-virtualenv

# Create and install our virtual environment so child images don't have to
RUN pip install virtualenv

RUN virtualenv /appenv && \
    . /appenv/bin/activate && \
    pip install uwsgi && \
    pip install pip --upgrade


# Entrypoint script
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
