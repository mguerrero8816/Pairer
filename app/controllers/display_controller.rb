class DisplayController < ApplicationController
  def see_class
    if params[:visibleClass] != 'No Classes'
      cookies[:visibleClass] = params[:visibleClass].slice! 6
    end
    redirect_to '/'
  end

  def pair
    students_to_pair = Student.where(class_number: cookies[:visibleClass])
    if enough_pairs && !cookies[:visibleClass].blank? && (students_to_pair.count)%2 == 0 && students_to_pair.count > 0
      @student_ids = []
      @pair_results = []
      if !students_to_pair.nil?
        students_to_pair.each {|student|
          @student_ids << student.id
        }
      end
      @pairs_bad = true
      while @pairs_bad
        @pairs_bad = false
        randomized_ids = form_pairs
      end

      randomized_ids.each {|count|
        @pair_results << "#{Student.find(count).first_name} #{Student.find(count).last_name}"
      }
      cookies[:pair_results] = @pair_results.to_yaml
      @current_pairs = cookies[:visibleClass].to_i
      cookies[:current_pairs] = @current_pairs
    else
      if !enough_pairs
        flash[:notice] = 'Not enough pairs available: Delete some old ones'
      elsif (students_to_pair.count)%2 == 1
        flash[:notice] = 'An even number of students are required to pair'
      elsif students_to_pair.count <= 0
        flash[:notice] = 'No students in selected class'
      else
        flash[:notice] = 'No class selected to pair'
      end
    end
    redirect_to '/'
  end

  def form_pairs
    if Pair.where(:class_number => cookies[:visibleClass].to_i).maximum('pair_set').nil?
      set_number = 1
    else
      set_number = Pair.where(:class_number => cookies[:visibleClass].to_i).maximum('pair_set') + 1
    end
    count = 0
    randomized = @student_ids.sample(@student_ids.length)
    #alphabetize the pairs
    alphabetized = []
    while count < randomized.length do
      if Student.find(randomized[count]).first_name + Student.find(randomized[count]).last_name < Student.find(randomized[count+1]).first_name + Student.find(randomized[count+1]).last_name
        alphabetized << randomized[count]
        alphabetized << randomized[count+1]
      else
        alphabetized << randomized[count+1]
        alphabetized << randomized[count]
      end
      count += 2
    end
    #reset the counter
    count = 0
    #end alphabetizing
    while count < alphabetized.length do
      if !Pair.where(:first_id => [alphabetized[count], alphabetized[count+1]], :second_id => [alphabetized[count], alphabetized[count+1]]).first.nil?
        @pairs_bad = true
      end
      count += 2
    end

    if !@pairs_bad
      count = 0
      while count < alphabetized.length do
        Pair.create(class_number: cookies[:visibleClass].to_i, pair_set: set_number, first_id: alphabetized[count], second_id: alphabetized[count+1], first_full_name: "#{Student.find(alphabetized[count]).first_name} #{Student.find(alphabetized[count]).last_name}", second_full_name: "#{Student.find(alphabetized[count+1]).first_name} #{Student.find(alphabetized[count+1]).last_name}")
        count += 2
      end
    end
    alphabetized
  end

  def enough_pairs
    number_of_slots = 2
    number_of_students = Student.where(:class_number => cookies[:visibleClass]).count
    number_of_pairs = Pair.where(:class_number => cookies[:visibleClass]).count
    number_of_combinations = calc_factorial(number_of_students) / (calc_factorial(number_of_slots) * calc_factorial(number_of_students - number_of_slots))
    (number_of_combinations - number_of_pairs) >= number_of_students/number_of_slots
  end

  def calc_factorial(num)
    result = 1
    num.times do |element|
      result *= (element+1)
    end
    result
  end
end
