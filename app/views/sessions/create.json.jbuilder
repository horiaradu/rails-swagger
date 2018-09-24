json.user do
  json.extract! resource, :id, :email
end
json.token @jwt
