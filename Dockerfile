# Use AlpineLinux as base image
FROM alpine:3.6 AS base

# Copy files
COPY conf/supervisord.conf /etc/supervisord.conf
COPY scripts/* /usr/bin/
COPY custom_scripts/* /custom_scripts/

# Set permissions and install webhook dependencies
# Comment: To keep the image small I've kicked out bash, supervisord, 
#          makes 0 sense to use that in this image. This also enables
#          us to use python3 instead of python2 (supervisor dep.)
RUN chmod +x /usr/bin/* \
    && chmod 755 /usr/bin/pull /usr/bin/push \
    && chmod +x -R /custom_scripts \
    && apk add --no-cache --update git openssh-client py3-requests

# Expose Webhook port
EXPOSE 8555

# run start script
CMD ["/bin/sh", "/usr/bin/start.sh"]