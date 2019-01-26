# Use AlpineLinux as base image
FROM alpine:3.6 AS base

FROM base AS builder
RUN mkdir /install

# Copy required files
COPY conf/supervisord.conf /install/etc/supervisord.conf
COPY scripts/* /install/usr/bin/
COPY custom_scripts/* /install/custom_scripts/

# Add permissions to our scripts
RUN chmod +x /install/usr/bin/* 
RUN chmod 755 /install/usr/bin/pull /install/usr/bin/push
RUN chmod +x -R /install/custom_scripts


FROM base 
COPY --from=builder /install /

# Install Git, bash, openssh and supervisor
RUN apk add --no-cache --update git openssh-client supervisor python3 py3-requests

# Expose Webhook port
EXPOSE 8555

# run start script
CMD ["/bin/sh", "/usr/bin/start.sh"]