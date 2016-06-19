class LandingController < ApplicationController
  def land
    seeClass
    seeOldPairs
    seeNewPairs
  end

  def seeClass
    if !cookies[:seeClass].nil?
      @class_students = Student.where('class_number = ?', cookies[:seeClass])
    end
  end

  def seeOldPairs
    if !cookies[:seeClass].nil?
      @student_pairs = Pair.where('class_number = ?', cookies[:seeClass])
    end
  end

  def seeNewPairs
    if !cookies[:pair_results].nil?
      @pair_results = YAML.load(cookies[:pair_results])
      @paired_class = cookies[:paired_class].to_i
    end
  end
end
