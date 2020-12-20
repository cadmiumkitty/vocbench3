FROM openjdk:8-jdk-buster

ENV vb_version=8.0.1
ENV st_version=8.0.1

RUN curl -L https://bitbucket.org/art-uniroma2/vocbench3/downloads/vocbench3-${vb_version}-full.zip --output /tmp/vocbench3-${vb_version}-full.zip

RUN set -eux ; \
	mkdir /opt/vocbench3 ; \
	mkdir /opt/vocbench3/data ; \
	cd /opt/vocbench3 ; \
	unzip -q /tmp/vocbench3-${vb_version}-full.zip -d . ; \
	chmod -R u=rwX,go=rX semanticturkey-${st_version} ; \
	chmod +x semanticturkey-${st_version}/bin/* ; \
	sed -i 's/\(data\.dir\)=.*/\1=..\/data\/SemanticTurkeyData/' /opt/vocbench3/semanticturkey-${st_version}/etc/it.uniroma2.art.semanticturkey.cfg ; \
	rm /tmp/vocbench3-${vb_version}-full.zip

WORKDIR /opt/vocbench3/semanticturkey-$st_version

EXPOSE 1979

ENTRYPOINT ["bin/karaf"]
CMD ["server"]
