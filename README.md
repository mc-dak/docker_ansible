# docker_ansible
образ сделан на базе redhat8 из-за безопасников. добавлены 2 rpm для корректной работы ansible
## сборка
sudo docker build -t ansible .
## выгрузка в tar
sudo docker save ansible > ansible.tar
## загружаем в docker images
sudo docker load --input ansible.tar

если ранее был образ с таким именем то перед загрузкой удаляем старый

sudo docker images

sudo docker rmi -f image_id
## добавляем тег
sudo docker tag ansible *new_name*
## отправляем в нексус
sudo docker push *new_name*
## забираем из нексуса
sudo docker pull *new_name*
## запуск
sudo docker run --rm network host -v $PWD:/playbook -w /playbook -v ~:/home/$USER -it ansible ansible-playbook -u $USER --private-key ~/.ssh/id_rsa test.yml -l *name_server*
### чтобы работали docker модули ansible вроде docker_login нужно добавить volume
-v /var/run/docker.sock:/var/run/docker.sock
### чтобы не писать такую длинную команду можно добавить в alias
vi ~/.bashrc

alias ansible-palybook="sudo docker run --rm network host -v \$PWD:/playbook -w /playbook -v ~:/home/$USER -it ansible ansible-playbook -u $USER --private-key ~/.ssh/id_rsa"

аналогично для команд ansible, ansible-config, ansible-inventory только для ansible-invenory и ansible-config можно не прописывать в alias ключи -u и --private-key 
