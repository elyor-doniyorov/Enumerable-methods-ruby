module Enumerable
  # my_each
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < to_a.length
      yield to_a[i]
      i += 1
    end
    self
  end

  # my_each_with_index
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < to_a.length
      yield(to_a[i], i)
      i += 1
    end
    self
  end

  # my_select
  def my_select
    return to_enum(:my_select) unless block_given?

    new_arr = []
    to_a.my_each { |item| new_arr << item if yield item }
    new_arr
  end

  def my_all?(param = nil)
    if block_given?
      to_a.my_each { |item| return false if yield(item) == false }
      return true
    elsif param.nil?
      to_a.my_each { |item| return false if item.nil? || item == false }
    elsif !param.nil? && (param.is_a? Class)
      to_a.my_each { |item| return false unless [item.class, item.class.superclass].include?(param) }
    elsif !param.nil? && param.instance_of?(Regexp)
      to_a.my_each { |item| return false unless param.match(item) }
    else
      to_a.my_each { |item| return false if item != param }
    end
    true
  end

  # my_any?
  def my_any?(param = nil)
    if block_given?
      to_a.my_each { |item| return true if yield(item) }
      return false
    elsif param.nil?
      to_a.my_each { |item| return true if item }
    elsif !param.nil? && (param.is_a? Class)
      to_a.my_each { |item| return true if [item.class, item.class.superclass].include?(param) }
    elsif !param.nil? && param.instance_of?(Regexp)
      to_a.my_each { |item| return true if param.match(item) }
    else
      to_a.my_each { |item| return true if item == param }
    end
    false
  end

  # my_none?
  def my_none?(param = nil)
    if block_given?
      !my_any?(&Proc.new)
    else
      !my_any?(param)
    end
  end

  # my_count
  def my_count(param = nil)
    j = 0
    if block_given?
      to_a.my_each { |item| j += 1 if yield(item) }
    elsif !block_given? && param.nil?
      j = to_a.length
    else
      j = to_a.my_select { |item| item == param }.length
    end
    j
  end

  # my_map
  def my_map(proc_x = nil)
    return enum_for unless block_given?

    map_list = []
    if proc_x.nil?
      my_each { |element| map_list.push(yield(element)) }
    else
      my_each { |element| map_list.push(proc_x.call(element)) }
    end
    map_list
  end

  # my_inject
  def my_inject(*args)
    list = is_a?(Range) ? to_a : self
    reduce = args[0] if args[0].is_a?(Integer)
    operator = args[0].is_a?(Symbol) ? args[0] : args[1]
    if operator
      list.my_each { |item| reduce = reduce ? reduce.send(operator, item) : item }
      return reduce
    end
    list.my_each { |item| reduce = reduce ? yield(reduce, item) : item }
    reduce
  end
end

def multiply_els(array)
  array.my_inject(1) { |product, i| product * i }
end
