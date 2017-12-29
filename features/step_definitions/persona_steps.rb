Given(/^the "(.*)" workflow exists$/) do |name|
  Cucumber::Persona.find(name).create
end
