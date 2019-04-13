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

DOCKER=docker
DOCKERIMAGENAME=uzka/torbrowser

BIN=docker-torbrowser

FF_VERSION=8.0.8
FF_LANG=en-US
FF_ARCH=linux64

all: $(DOCKERIMAGENAME)

$(DOCKERIMAGENAME): Dockerfile
	docker build --build-arg FFLANG=$(FF_LANG) --build-arg VERSION=$(FF_VERSION) --build-arg ARCH=$(FF_ARCH) -t $@ .
	mkdir -p $(@D)
	touch $@

download:
	docker pull $(DOCKERIMAGENAME)

clean:
	rm -fr $(DOCKERIMAGENAME)
distclean: clean
	docker rmi $(DOCKERIMAGENAME)
maintainer-clean: distclean

install:
	cp $(BIN) /usr/local/bin/
