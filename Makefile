all: configure build migrate assets daemon

##################### Bootstrapping commands

configure:
	./configure

build:
	docker-compose build

migrate:
	docker-compose run lms ./manage.py lms migrate --settings=production
	docker-compose run cms ./manage.py cms migrate --settings=production

assets:
	docker-compose run lms paver update_assets lms --settings=production
	docker-compose run cms paver update_assets cms --settings=production

##################### Running commands

up:
	docker-compose up

daemon:
	docker-compose up -d && \
	echo "Daemon is up and running"

stop:
	docker-compose stop

##################### Debug commands

lms-shell:
	docker-compose run lms ./manage.py lms shell --settings=production
cms-shell:
	docker-compose run lms ./manage.py cms shell --settings=production

import-demo-course:
	docker-compose run cms git clone https://github.com/edx/edx-demo-course ../edx-demo-course && \
		cd ../edx-demo-course && \
		git checkout open-release/ginkgo.master && \
		cd ../edx-platform && \
	python ./manage.py cms --settings=production import ../data ../edx-demo-course
