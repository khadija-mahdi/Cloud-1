
deploy:
	@ansible-playbook -i inventory.ini playbook.yaml

deploy-mariadb:
	@ansible-playbook -i inventory.ini playbook.yaml --tags mariadb

deploy-wordpress:
	@ansible-playbook -i inventory.ini playbook.yaml --tags wordpress

deploy-nginx:
	@ansible-playbook -i inventory.ini playbook.yaml --tags nginx

deploy-phpmyadmin:
	@ansible-playbook -i inventory.ini playbook.yaml --tags phpmyadmin

up:
	@docker-compose -f srcs/docker-compose.yml up --build -d

mariadb:
	@docker-compose -f srcs/docker-compose.yml up -d --build mariadb

wordpress:
	@docker-compose -f srcs/docker-compose.yml up -d --build wordpress

nginx:
	@docker-compose -f srcs/docker-compose.yml up -d --build nginx

phpmyadmin:
	@docker-compose -f srcs/docker-compose.yml up -d --build phpmyadmin

down:
	@docker-compose -f srcs/docker-compose.yml down

rmove_volumes:
	@docker-compose -f srcs/docker-compose.yml down -v
	@sudo rm -rf /home/ubuntu/data/wordpress/*
	@sudo rm -rf /home/ubuntu/data/mariadb/*

remove_images:
	@docker-compose -f srcs/docker-compose.yml down --rmi all

clean: down rmove_volumes remove_images

fclean: rmove_volumes remove_images 
	@docker-compose -f srcs/docker-compose.yml down 
	@docker system prune --all
