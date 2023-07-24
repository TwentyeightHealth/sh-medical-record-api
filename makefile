# build image using dockerfile
build-image:
	docker image build .t jamelclarke/medical-record-api
#
tag-image:
	docker tag jamelclarke/medical-record-search jamelclarke/medical-record-search:${tag}
#
push-image:
	docker push jamelclarke/medical-record-search:${tag}

# create container using the image created by dockerfile
run-image:
	docker run -p 7000:7000 jamelclarke/medical-record-api:${tag}

# wipe development containers and data clean
wipe-dev:
	rm -rf ./prisma/migrations
	docker compose down -v

# create an image and start the containers using compose.yaml
up-dev:	
	pnpm prisma generate
	pnpm prisma format
	docker compose up --build -d
	pnpm prisma migrate reset
	pnpm prisma migrate dev --name init

# stop development containers
down-dev:
	docker compose down
