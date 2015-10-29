
def range(start, finish)
  return [finish] if start == finish
  [start].push(*range(start+1, finish))
end

def sum_recursive(arr)
  return arr.first if arr.size == 1
  sum_recursive(arr[1..-1]) + arr.first
end

def sum_iterative(arr)
  total_sum = 0
  arr.each { |i| total_sum += i}
  total_sum
end

def exponent_1(base, n)
  return 1 if n == 0
  base * exponent_1(base, n-1)
end

def exponent_2(base, n)
  return 1 if n == 0
  return base if n == 1
  if n.even?
    exponent_2(base, n/2) * exponent_2(base, n/2)
  else
    base * (exponent_2(base, (n-1)/2)) * (exponent_2(base, (n-1)/2))
  end
end

def deep_dup(arr)
  return arr unless arr.is_a?(Array)
  copy = []
  arr.each do |el|
    copy << deep_dup(el)
  end
  copy
end

def fibonacci(n)
  return [1] if n == 1
  return [1, 1] if n == 2
  previous = fibonacci(n-1)
  previous << (previous[-1] + previous[-2])
end

def fibonacci_iter(n)
  return [1, 1] if n == 2
  return [1] if n == 1
  return [] if n == 0
  counter = n
  fib = [1, 1]
  while counter > 2
    fib << fib[-1] + fib[-2]
    counter -= 1
  end
    fib
end

def bsearch(array, target)
  return 0 if array.length == 1 && array[0] == target
  return nil if array.length == 1 && array[0] != target
  mid = array.length/2
  sub_array1 = array[0..mid-1]
  sub_array2 = array[mid...array.length]
  if array[mid] > target
    bsearch(sub_array1, target)
  elsif array[mid] < target
    greater = bsearch(sub_array2, target)
    greater + sub_array1.length unless greater.nil?
  else
    mid
  end
end

def make_change(total, coins)
  return [] if total == 0
  best_changes = []
  coins.each_with_index do |coin, idx|
    next if coin > total
    leftover = total - coin
    new_change = make_change(leftover, coins[idx..-1])
    new_change.unshift(coin)
    best_changes.push(new_change)
  end
  best_changes.min_by { |change| change.length }
end

def make_change2(num, array)
  return if num == 0 || array.empty?
  temp_num = num
  change = []
  if temp_num >= array[0]
    temp_num -= array[0]
    change << array[0]
  end
  if temp_num < array[0]
    new_change = make_change2(temp_num, array[1..-1])
  else
    new_change = make_change2(temp_num, array)
  end
  change << new_change unless new_change.nil?
  change.flatten
end

def make_change3(num, array)
  current_best = make_change2(num, array)
  change = []
  i = 1
  temp_num = num
  while i < array.length
      temp_num -= array[i]
      change << array[i]
      change << make_change2(temp_num, array).flatten
      current_best = change.flatten.dup if current_best.size > change.flatten.size
      i += 1
    end
    current_best
end

def merge(left, right)
  sorted_array = []

  i = 0
  j = 0
  while i < left.length || j < right.length
    if i >= left.length
      sorted_array << right[j]
      j += 1
    elsif j >= right.length
      sorted_array << left[i]
      i += 1
    else
      if left[i] <= right[j]
        sorted_array <<  left[i]
        i += 1
      elsif right[j] < left[i]
        sorted_array << right[j]
        j += 1
      end
    end
  end

  sorted_array
end

def merge_sort(array)
  return array if array.length <= 1
  left_array = array[0..array.length/2-1]
  right_array = array[array.length/2...array.length]
  merge(merge_sort(left_array), merge_sort(right_array))
end

def subsets(array)
  puts "#{array}"
  return [[]] if array.empty?
  a = subsets(array[0..-2])
  b = deep_dup(a).each {|el| el << array.last}
  return a.concat(b)
end
