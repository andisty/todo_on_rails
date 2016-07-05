require 'rails_helper'

feature 'Manage tasks', js: true do
  scenario 'We can add a new task' do
    #point your browser towards the todo path
    visit todos_path
    #enter description in the textfield
    fill_in 'todo_title', with: 'Be Batman'
    #press enter (submit the form)
    page.execute_script("$('form').submit()")
    #now test #2 A new task is displayed in the list of tasks
    expect(page).to have_content('Be Batman')
  end
end

feature 'Todo count change', js: true do
  scenario 'counter changes' do
    visit todos_path
    fill_in 'todo_title', with: 'Eat a cheese burger'
    page.execute_script("$('form').submit()")
    # Wait for 1 second so the counter can be updated
    sleep(1)
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
  end
end


feature 'Complete a task', js: true do
  scenario 'complete a task' do
    visit todos_path
    fill_in 'todo_title', with: 'go to candy mountain'
    page.execute_script("$('form').submit()")
    check('todo-1')
    # Wait for 1 second so the counter can be updated
    sleep(1)
    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
  end
end

feature '3 tasks multiple action', js: true do
  scenario '3 tasks multiple action' do
    visit todos_path
    fill_in 'todo_title', with: 'Lets do some tests'
    page.execute_script("$('form').submit()")
    fill_in 'todo_title', with: 'lets smoke a joint'
    page.execute_script("$('form').submit()")
    fill_in 'todo_title', with: 'Lets have sex'
    page.execute_script("$('form').submit()")
    expect(page).to have_content('Lets do some tests')
    expect(page).to have_content('lets smoke a joint')
    expect(page).to have_content('Lets have sex')
    check('todo-1')
    check('todo-2')
    sleep(1)
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
  end
end

feature '3 tasks clean up', js: true do
  scenario '3 tasks clean up' do
    visit todos_path
    fill_in 'todo_title', with: 'Lets do some tests'
    page.execute_script("$('form').submit()")
    fill_in 'todo_title', with: 'lets smoke a joint'
    page.execute_script("$('form').submit()")
    fill_in 'todo_title', with: 'Lets have sex'
    page.execute_script("$('form').submit()")
    expect(page).to have_content('Lets do some tests')
    expect(page).to have_content('lets smoke a joint')
    expect(page).to have_content('Lets have sex')
    check('todo-1')
    check('todo-2')
    page.execute_script("$('#clean-up').click()")
    sleep(1)
    expect( page.find(:css, 'span#total-count').text ).to eq "1"
  end
end
