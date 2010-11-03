Factory.define :role do |f|
  f.name  "user"
end

Factory.define :user do |f|
  f.email {"#{rand(10**10)}@email.com"}
  f.password "blahblah"
  f.password_confirmation "blahblah"
  f.association :role
end