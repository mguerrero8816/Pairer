class ManagerController < ApplicationController
  def add_student
    if !params[:firstName].blank? && !params[:lastName].blank? &&
      new_student = Student.new
      new_student.first_name = params[:firstName].strip.capitalize
      new_student.last_name = params[:lastName].strip.capitalize
      new_student.class_number = params[:classNumber]
      new_student.save
      cookies[:visibleClass] = params[:classNumber]
      delete_pair_sets
    else
      flash[:notice] = 'Full name required'
      redirect_to '/'
    end
  end

  def delete
    student_to_delete = Student.find_by_first_name_and_last_name(params[:displayedFirstName], params[:displayedLastName])
    first_pairs_to_delete = Pair.where(:first_id => student_to_delete.id)
    second_pairs_to_delete = Pair.where(:second_id => student_to_delete.id)

    first_pairs_to_delete.each do |num|
      num.destroy
    end
    second_pairs_to_delete.each do |num|
      num.destroy
    end
    student_to_delete.destroy
    redirect_to '/'
  end

  def delete_pair
    @delete_this = Pair.find_by_first_id_and_second_id(params[:displayedFirstId], params[:displayedSecondId])
    @delete_this.destroy
    redirect_to '/'
  end

  def delete_pair_sets
    if params[:delete_pair].nil?
      target_pairs = Pair.where(:class_number => params[:classNumber])
    elsif params[:delete_pair] == "All"
      target_pairs = Pair.where(:class_number => cookies[:visibleClass])
    else
      target_pairs = Pair.where(:class_number => cookies[:visibleClass], :pair_set => (params[:delete_pair].slice! 4))
    end
    target_pairs.each do |item|
      item.destroy
    end
    redirect_to '/'
  end
end
