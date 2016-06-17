require 'rails_helper'

RSpec.feature "DeleteStudents", type: :feature do
  context 'when viewing a list of student' do
    Steps 'deleting a student' do
      When 'I visit the landing page and add some students' do
        visit '/'
        fill_in 'firstName', with:('Mike')
        fill_in 'lastName', with:('Guerrero')
        select '1', :from => 'classNumber'
        click_button 'Add Student'
      end
      Then 'I can see the students in a class' do
        select 'Class 1', :from => 'seeClass'
        click_button 'See Class'
      end
      And 'I can click the delete button to remove the student from the view and database' do
        click_link 'Delete'
        expect(page).to_not have_content('Mike Guerrero')
        expect(Student.all.first).to be_nil
      end
    end
  end
end
