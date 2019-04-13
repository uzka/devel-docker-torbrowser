##  Copyright 2019 Uzka
## 
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
## 
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
## 
##  You should have received a copy of the GNU General Public License
##  along with this program.  If not, see <https://www.gnu.org/licenses/>.

FROM debian:stable

MAINTAINER Uzka <developeruzka@gmail.com>

ARG USER=anon


RUN useradd -m -d /home/$USER $USER

RUN apt-get update \
	&& apt-get install -y xz-utils libgtk-3-0 libdbus-glib-1-2 libxt6 wget gnupg2 --no-install-recommends \
	&& apt-get clean \
	&& rm -fr /var/lib/apt/lists/* \
	&& ln -s /home/$USER/tor-browser/Browser/start-tor-browser /usr/local/bin/firefox

USER $USER:$USER

WORKDIR /home/$USER

COPY EF6E286DDA85EA2A4BA7DE684E2C6E8793298290.asc key.asc

# WARNING: Version is updated only on Makefile
ARG VERSION=8.0.9

ARG ARCH=linux64
ARG FFLANG=en-US
#ARG URL=https://www.torproject.org/dist/torbrowser/"$VERSION"/tor-browser-"$ARCH"-"$VERSION"_"$FFLANG".tar.xz
ARG URL=https://archive.torproject.org/tor-package-archive/torbrowser/"$VERSION"/tor-browser-"$ARCH"-"$VERSION"_"$FFLANG".tar.xz

RUN wget -nv --no-check-certificate -O tor-browser.tar.xz $URL \
	&& wget -nv --no-check-certificate -O tor-browser.tar.xz.asc $URL.asc \
	&& gpg --import key.asc \
	&& gpg --verify tor-browser.tar.xz.asc \
	&& tar xf tor-browser.tar.xz \
	&& rm tor-browser.tar.xz tor-browser.tar.xz.asc key.asc \
	&& ln -s tor-browser_* tor-browser

CMD firefox
