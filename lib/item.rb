class Item
  attr_reader :name, :type, :min_temp, :max_temp

  def initialize(params)
    @name = params[:name]
    @type = params[:type]
    @min_temp = params[:min_temp]
    @max_temp = params[:max_temp]
  end

  def suits_temperature?(temperature)
    (@min_temp..@max_temp).include?(temperature)
  end

  def to_s
    "#{@name} (#{@type}) #{@min_temp}..#{@max_temp}"
  end
end
