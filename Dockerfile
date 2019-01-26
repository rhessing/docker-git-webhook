# Use AlpineLinux as base image
FROM alpine:3.6

# Install Git, bash, openssh and supervisor
RUN apk add --no-cache --update git openssh-client supervisor python py-pip \
    && pip install requests

# Copy required files
COPY conf/supervisord.conf /etc/supervisord.conf
COPY scripts/* /usr/bin/
COPY custom_scripts/* /custom_scripts/

# Add permissions to our scripts
RUN chmod +x /usr/bin/run_custom_scripts_* /usr/bin/docker-hook /usr/bin/hook-listener \
    && chmod 755 /usr/bin/pull /usr/bin/push \
    && chmod +x -R /custom_scripts

# Expose Webhook port
EXPOSE 8555

# run start script
CMD ["/bin/sh", "/usr/bin/start.sh"]