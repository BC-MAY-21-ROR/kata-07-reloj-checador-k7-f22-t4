Rake::Task['db:schema:load'].clear
task 'db:schema:load' do
end

Rake::Task['db:migrate'].clear
task 'db:migrate' do
end
