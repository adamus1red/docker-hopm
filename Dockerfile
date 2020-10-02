FROM gcc:10
#COPY ./hopm /usr/src/hopm
RUN git clone https://github.com/ircd-hybrid/hopm.git /usr/src/hopm
WORKDIR /usr/src/hopm
RUN ./configure --prefix=/usr/local --sysconfdir=/hopm && make && make install && rm -rf /usr/src/hopm
WORKDIR /hopm
CMD ["/usr/local/bin/hopm", "-d"]
