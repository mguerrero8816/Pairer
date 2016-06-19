class LandingController < ApplicationController
  def land
    displayClass
    displayOldPairs
    displayNewPairs
  end

  def displayClass
    if !cookies[:visibleClass].nil?
      @class_students = Student.where('class_number = ?', cookies[:visibleClass])
    end
  end

  def displayOldPairs
    if !cookies[:visibleClass].nil?
      @used_pairs = Pair.where('class_number = ?', cookies[:visibleClass])
    end
  end

  def displayNewPairs
    if !cookies[:pair_results].nil?
      @pair_results = YAML.load(cookies[:pair_results])
      @current_pairs = cookies[:current_pairs].to_i
    end
  end
end
