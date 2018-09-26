FROM java:8-jdk

# JIRA CORE
RUN \
    wget https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-core-7.5.0-x64.bin -O /usr/src/atlassian-jira-core-7.5.0-x64.bin && \
    chmod +x /usr/src/atlassian-jira-core-7.5.0-x64.bin && \
    echo "executeLauncherAction$Boolean=true" >> /usr/src/atlassian-jira-core.varfile && \
    echo "app.install.service$Boolean=true" >> /usr/src/atlassian-jira-core.varfile && \
    echo "sys.installationDir=/opt/atlassian/jira" >> /usr/src/atlassian-jira-core.varfile && \
    /usr/src/atlassian-jira-core-7.5.0-x64.bin -q -varfile /usr/src/atlassian-jira-core.varfile

# JIRA Software
RUN \
    wget https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-7.5.0-x64.bin -O /usr/src/atlassian-jira-software-7.5.0-x64.bin && \
    chmod +x /usr/src/atlassian-jira-software-7.5.0-x64.bin && \
    echo "executeLauncherAction$Boolean=true" >> /usr/src/atlassian-jira-software.varfile && \
    echo "app.install.service$Boolean=true" >> /usr/src/atlassian-jira-software.varfile && \
    echo "sys.confirmedUpdateInstallationString=true" >> /usr/src/atlassian-jira-software.varfile && \
    /usr/src/atlassian-jira-software-7.5.0-x64.bin -q -varfile /usr/src/atlassian-jira-software.varfile

# JIRA ServiceDesk
RUN \
    wget https://www.atlassian.com/software/jira/downloads/binary/atlassian-servicedesk-3.8.1-x64.bin -O /usr/src/atlassian-servicedesk-3.8.1-x64.bin && \
    chmod +x /usr/src/atlassian-servicedesk-3.8.1-x64.bin && \
    echo "executeLauncherAction$Boolean=true" >> /usr/src/atlassian-servicedesk.varfile && \
    echo "app.install.service$Boolean=true" >> /usr/src/atlassian-servicedesk.varfile && \
    echo "sys.confirmedUpdateInstallationString=true" >> /usr/src/atlassian-servicedesk.varfile && \
    /usr/src/atlassian-servicedesk-3.8.1-x64.bin -q -varfile /usr/src/atlassian-servicedesk.varfile

# Add jira user to 'nobody' group (as secondary)
RUN \
    usermod -a -G nogroup jira

CMD ["/opt/atlassian/jira/bin/start-jira.sh", "-fg"]
