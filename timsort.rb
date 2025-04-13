class TimSort
  def initialize(arr)
    @arr = arr
    @RUN = 32
    timSort(arr, arr.size)
  end

  def insertionSort(arr, left, right)
    (left + 1).upto(right) do |idx|
      tmp = arr[idx]
      idx2 = idx - 1

      while idx2 >= left && arr[idx2] > tmp
        arr[idx2 + 1] = arr[idx2]
        idx2 -= 1
      end
      arr[idx2 + 1] = tmp
    end
  end

  def merge(arr, left, mid, right)
    length1 = mid - left + 1
    length2 = right - mid

    leftArr = arr[left, length1]
    rightArr = arr[mid + 1, length2]

    i = 0
    j = 0
    k = left

    while i < length1 && j < length2 do
      if leftArr[i] <= rightArr[j] then
        arr[k] = leftArr[i]
        i += 1
      else
        arr[k] = rightArr[j]
        j += 1
      end
      k += 1
    end

    while i < length1 do
      arr[k] = leftArr[i]
      k += 1
      i += 1
    end
    
    while j < length2 do
      arr[k] = rightArr[j]
      k += 1
      j += 1
    end
  end

  def timSort(arr, n)
    (0...n).step(@RUN) do |i|
      insertionSort(arr, i, [i + @RUN - 1, n - 1].min)
    end

    size = @RUN
    while size < n do
      (0...n).step(2 * size) do |left|
        mid = left + size - 1
        right = [left + 2 * size - 1, n - 1].min
        if mid < right then
          merge(arr, left, mid, right)
        end
      end
      size *= 2
    end
  end
end

arr = Array.new(100) { rand(200) }

start_time = Time.now
tim = TimSort.new(arr)
end_time = Time.now

puts arr.sort == arr
puts end_time - start_time