FactoryBot.define do
    factory :task do
        name { 'test_name' }
        content { 'test_content' }
        deadline { "2021-10-07" }
        status { 'completed' }
        priority { 2 }
    end
    factory :second_task, class: Task do
        name { 'test_name_second' }
        content { 'test_second_content' }
        status { 'unstarted' }
        deadline { "2021-10-01" }
        priority { 0 }
    end
end