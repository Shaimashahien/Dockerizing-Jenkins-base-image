FROM jenkins/jenkins:lts

USER root

# Install Python 3
RUN apt-get update && apt-get install -y python3 python3-pip wget unzip

# Install pip 
#RUN apt-get install -y python-pip

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_amd64.zip \
   && unzip terraform_1.1.9_linux_amd64.zip -d /usr/local/bin/ \
   && chmod +x /usr/local/bin/terraform

# Install Ansible
RUN pip install ansible 

# Install Docker
RUN apt-get update && apt-get install -y docker.io

# Install extra Python packages
RUN pip install boto3 fabric

# Configure Jenkins 
COPY ./jenkins-config/* /var/jenkins_home/
RUN chown -R jenkins:jenkins /var/jenkins_home/
USER jenkins
