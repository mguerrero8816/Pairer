require 'rails_helper'

RSpec.feature "SeeClasses", type: :feature do
  context 'on landing page after generating students' do
    Steps 'seeing students' do
      When 'I visit the page' do
        visit '/'
      end
      Then 'I should see No Classes if the database is empty' do
        expect(page).to have_content 'No Classes'
      end
      When 'I add some students to the database' do
        fill_in 'firstName', with: 'Mike'
        fill_in 'lastName', with: 'Guerrero'
        select '1', :from => 'classNumber'
        click_button 'Add Student'
        fill_in 'firstName', with: 'Someone'
        fill_in 'lastName', with: 'Here'
        select '1', :from => 'classNumber'
        click_button 'Add Student'
        fill_in 'firstName', with: 'Something'
        fill_in 'lastName', with: 'Else'
        select '1', :from => 'classNumber'
        click_button 'Add Student'
        fill_in 'firstName', with: 'Kevin'
        fill_in 'lastName', with: 'Bacon'
        select '2', :from => 'classNumber'
        click_button 'Add Student'
      end
      Then 'I can see a list of buttons for all classes' do
        expect(page).to have_content 'Class 1'
        expect(page).to have_content 'Class 2'
      end
      And 'I can select a class from the list of classes' do
        select 'Class 1', :from => 'seeClass'
      end
      And 'I can click on the See Class button' do
        click_button 'See Class'
      end
      Then 'I can see all students in that class' do
        expect(page).to have_content 'Mike Guerrero'
        expect(page).to have_content 'Someone Here'
        expect(page).to have_content 'Something Else'
      end
    end
  end

  context 'adding a student after selecting a class view' do
    Steps 'adding additional students to a class' do
      When 'I visit the page for the first time' do
        visit '/'
      end
      Then 'I should see No Classes if the database is empty' do
        expect(page).to have_content 'No Classes'
      end
      When 'I add some students to the database' do
        fill_in 'firstName', with: 'Mike'
        fill_in 'lastName', with: 'Guerrero'
        select '1', :from => 'classNumber'
        click_button 'Add Student'
        fill_in 'firstName', with: 'Someone'
        fill_in 'lastName', with: 'Here'
        select '1', :from => 'classNumber'
        click_button 'Add Student'
        fill_in 'firstName', with: 'Something'
        fill_in 'lastName', with: 'Else'
        select '1', :from => 'classNumber'
        click_button 'Add Student'
        fill_in 'firstName', with: 'Kevin'
        fill_in 'lastName', with: 'Bacon'
        select '2', :from => 'classNumber'
        click_button 'Add Student'
      end
      And 'I can select a class from the list of classes' do
        select 'Class 1', :from => 'seeClass'
      end
      And 'I can click on the See Class button' do
        click_button 'See Class'
      end
      Then 'I can see all students in that class' do
        expect(page).to have_content 'Mike Guerrero'
        expect(page).to have_content 'Someone Here'
        expect(page).to have_content 'Something Else'
      end
      When 'I add a person to that class' do
        fill_in 'firstName', with: 'Mr.'
        fill_in 'lastName', with: 'Anderson'
        select '1', :from => 'classNumber'
        click_button 'Add Student'
      end
      Then 'I can see an updated list of students in the class' do
        expect(page).to have_content 'Mike Guerrero'
        expect(page).to have_content 'Someone Here'
        expect(page).to have_content 'Something Else'
        expect(page).to have_content 'Mr. Anderson'
      end
    end
  end
end
