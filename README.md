# Приложение "Шашлыки" на Ruby On Rails.

Проект реализован на Ruby on Rails v5.1.6

## Краткое описание

Приложение позволяет планировать совместные мероприятий c друзьями. После регистрации пользователь может добавить мероприятие, в котором могут принять участие другие пользователи. Можно ограничить  доступ к мероприятию с помощью пинкода.

В приложении использованы следующие технологии:

 - Отправка электронной почты через SendGrid
 - Загрузка и хранение файлов на Amazon S3 storage (AWS)
 - Обработка изображений на сервере (CarrierWave, imagemagick)

## Настройки и запуск
Перед запуском приложения необходимо выполнить установку всех необходимых гемов и подготовку базы данных. Для этого в консоли в директории с приложением необходимо выполнить команды:

    sudo apt-get install imagemagick libmagickwand-dev
    bundle
    rails db:migrate

А так же необходимо установить переменные окружения для работы:

Amazon S3 Storage:
    
 - S3_ACCESS_KEY
    
 - S3_BUCKET_NAME
    
 - S3_BUCKET_REGION


SendGrid:

 - SENDGRID_USERNAME
   
 - SENDGRID_PASSWORD

Для запуска локального сервера необходимо выполнить команду:

    rails s

## Демо
[Приложение](https://bbqdimaon.herokuapp.com/) развернуто на heroku

Автор:  [Куликов Дмитрий](https://github.com/Dimaon)
