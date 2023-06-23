FactoryBot.define do
  factory :task do
    name { "Sample Task" }
    association :project
  end
end