# README

* Version

  Ruby 2.4.3
  Rails 5.1.6

* Database creation

  rails db:create
  rails db:populate

* Authentication Request cURL

  curl -X POST \
    http://localhost:3000/auth_user \
    -H 'Cache-Control: no-cache' \
    -H 'Postman-Token: f994b81e-008f-460f-b8a2-15a3b76238c8' \
    -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
    -F email=%{email} \
    -F password=%{password}

* Search Request cURL

  curl -X GET \
  	'http://localhost:3000/search?search=horror' \
    -H 'Authorization: Bearer %{jwt_token}' \
    -H 'Cache-Control: no-cache' \
    -H 'Postman-Token: 8b7aeaab-5173-492b-b8a5-5617d782fd1e'


