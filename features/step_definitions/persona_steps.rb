Given(/^I am ([a-zA-z]+ [a-zA-z]+)$/) do |name|
  Cucumber::Persona.find(name).create
end

Given(/^([a-zA-z]+ [a-zA-z]+) exists$/) do |name|
  Cucumber::Persona.find(name).create
end

Given(/^the "(.*)" workflow exists$/) do |name|
  Cucumber::Persona.find(name).create
end
