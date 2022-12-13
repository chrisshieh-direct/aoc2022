def is_palindrome?(str)
  return true if str.length == 1 || str.empty?

  i = 0
  e = -1
  pal = nil

  until i == str.length / 2
    return false if str[i] != str[e]
    i += 1
    e -= 1
  end
  true
end

def find_longest_pal(str)
  return '' if str.empty?
  return str if str.length == 1

  longest = ''

  0.upto(str.length - 1) do |x|
    current = ''
    current = expand_around_center(str, x, x)
    longest = current if current.length > longest.length

    current = expand_around_center(str, x, x + 1)
    longest = current if current.length > longest.length
  end
  longest
end

def expand_around_center(str, left, right)
  until left < 0 || right == str.length
    break unless str[left - 1] == str[right + 1]
    left -= 1
    right += 1
  end
  str[left..right]
end

p find_longest_pal("wefowijoijamanaplanacanalpanamasoifjoisisssssiefqwoeijfradaroijwoefijwoeijf")
