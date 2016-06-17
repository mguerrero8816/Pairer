require 'rails_helper'

RSpec.feature "LandingPages", type: :feature do
  context 'visiting website' do
    Steps 'visit website' do
      When 'I visit the website' do
        visit '/'
      end
      Then 'I should see a greeting' do
        expect(page).to have_content('Pair Students')
      end
    end
  end

  context 'add student form' do
    Steps 'fill in student form' do
      When 'I visit the website' do
        visit '/'
      end
      And 'I can enter a students first and last name' do
        fill_in 'firstName', with:('Mike')
        fill_in 'lastName', with:('Guerrero')
      end
      And 'I can select a class number' do
        select '1', :from => 'classNumber'
      end
      Then 'I can send the information with a button' do
        click_button('Add Student')
      end
    end
  end

  context 'add student method' do
    Steps 'add student to database' do
      When 'I visit the website' do
        visit '/'
      end
      And 'I can enter a students first and last name' do
        fill_in 'firstName', with:('Mike')
        fill_in 'lastName', with:('Guerrero')
      end
      And 'I can select a class number' do
        select '1', :from => 'classNumber'
      end
      When 'I add the student to the database' do
        click_button('Add Student')
      end
      Then 'the student exists in the database' do
        expect(Student.all.first.first_name).to eq 'Mike'
      end
      And 'I can add a student to the next highest class number' do
        fill_in 'firstName', with:('Someone')
        fill_in 'lastName', with:('Else')
        select '2', :from => 'classNumber'
        click_button('Add Student')
      end
      And 'the student exists in the database' do
        expect(Student.find_by_first_name('Someone').class_number).to eq 2
      end
    end
  end

end
