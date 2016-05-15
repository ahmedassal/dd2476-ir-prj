# Base image.  You can pull from Docker Hub.  Codenvy
# provides a series of tested base images that include
# Web Shell, installed utilities, and language support.
# You can browse our images in Docker Hub or at
# github.com/codenvy/dockerfiles. The shellinabox image
# provides core Linux utilities and terminal access to runner.
FROM codenvy/shellinabox
USER root
#RUN ls
RUN apt-get update  >/dev/null 2>&1
RUN apt-get install -y bzip2 >/dev/null 2>&1
RUN apt-get install -y git >/dev/null 2>&1
RUN mkdir -p /home/user/dd2476-ir-prj2/
#RUN git clone https://github.com/ahmedassal/dd2476-ir-prj.git
WORKDIR /home/user/dd2476-ir-prj2/
ADD . /home/user/dd2476-ir-prj2/
RUN unzip -o dd2476-ir-prj2.zip >/dev/null 2>&1

WORKDIR /home/user/dd2476-ir-prj2/input_pipeline
RUN wget http://nlp.stanford.edu/software/stanford-corenlp-full-2014-06-16.zip >/dev/null 2>&1
RUN unzip -o stanford-corenlp-full-2014-06-16.zip  >/dev/null 2>&1
RUN mv stanford-corenlp-full-2014-06-16.zip stanford-corenlp.zip
RUN unzip nltk_data.zip >/dev/null 2>&1
RUN ls -arlth

RUN sudo wget http://repo.continuum.io/archive/Anaconda3-4.0.0-Linux-x86_64.sh >/dev/null 2>&1
RUN sudo bash Anaconda3-4.0.0-Linux-x86_64.sh -b -p $HOME/anaconda >/dev/null 2>&1
ENV PATH $HOME/anaconda/bin:$PATH
RUN $HOME/anaconda/bin/conda create --name irprj2_7 python=2.7 Anaconda matplotlib scikit-learn gensim >/dev/null 2>&1
##WORKDIR $HOME/anaconda/bin

##COPY dd2476-ir-prj2/ /dd2476-ir-prj2/


##RUN $HOME/anaconda/bin/activate irprj2.7
##CMD ["bash", "--rcfile", "$HOME/anaconda/bin"]
##RUN . ~/anaconda/bin/activate irprj2.7
RUN /bin/bash -c "source ~/anaconda/bin/activate irprj2_7"
##RUN /bin/bash -c "source activate irprj2_7"
##RUN source activate irprj2_7


# Codenvy uses this port to map IDE clients to the output of
# your application executing within the Runner. Set these
# values to the port of your application and Codenvy will
# map this port to the output within the browser, CLI, and API.
# You can set this value multiple times.
# For example:
# ENV CODENVY_APP_PORT_8080_HTTP 8080
#
# ENV CODENVY_APP_PORT_<port>_HTTP <port>

# Codenvy uses this port to map IDE clients to the debugger
# of your application within the Runner. Set these
# values to the port of your debugger and Codenvy will
# map this port to the debugger console in the browser.
# You can set this value multiple times.
# For example:
# ENV CODENVY_APP_PORT_8000_DEBUG 8000
#
# ENV CODENVY_APP_PORT_<port>_DEBUG <port>

# Set this value to the port of any terminals operating
# within your runner.  If you inherit a base image from
# codenvy/shellinabox (or any of our images that inherit
# from it, you do not need to set this value.  We already
# set it for you.
# ENV CODENVY_WEB_SHELL_PORT <port>

# Execute your custom commands here.  You can add
# as many RUN commands as you want.  Combining
# RUN commands into a single entry will cause your
# environment to load faster.  Also, building your image
# with docker offline and uploading it to Docker Hub
# as a pre-built base image will also cause it to load
# Faster.  This example installs python, curl, and the
# Google SDK as an example.
# RUN sudo apt-get update -y && \\
#     sudo apt-get install --no-install-recommends -y -q curl build-essential python3 python3-dev python-pip git python3-pip && \\
#     sudo pip3 install -U pip && \\
#     sudo pip3 install virtualenv && \\
#     sudo mkdir /opt/googlesdk && \\
#     wget -qO- \"https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz\" | sudo tar -zx -C /opt/googlesdk && \\
#     sudo /bin/sh -c \"/opt/googlesdk/google-cloud-sdk/install.sh\" && \\
#     sudo chmod +x /opt/googlesdk/google-cloud-sdk/bin/gcloud

# Include this as the CMD instruction in your Dockerfile if
# you'd like the runner to stay alive after your commands
# have finished executing. Keeping the runner alive is
# necessary if you'd like to terminal into the image.  If
# your Dockerfile launches a server or daemon, like Tomcat,
# you do not need to set this value as Docker will not
# terminate until that process has finished.
CMD sleep 365d