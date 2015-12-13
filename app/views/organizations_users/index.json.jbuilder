json.array!(@organizations_users) do |organizations_user|
  json.extract! organizations_user, :id
  json.url organizations_user_url(organizations_user, format: :json)
end
