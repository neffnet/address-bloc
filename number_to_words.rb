# number to words, accepts one number argument

num = ARGV[0]
digits = num.to_s.length
blocks = (digits.to_f / 3).ceil

@number_words = { 0=> '', 1=> 'one', 2=> 'two', 3=> 'three', 4=> 'four', 5=> 'five', 6=> 'six', 7=> 'seven', 8=> 'eight', 9=> 'nine', 10=> 'ten', 11=> 'eleven', 12=> 'twelve', 13=> 'thirteen', 14=> 'fourteen', 15=> 'fifteen', 16=> 'sixteen', 17=> 'seventeen', 18=> 'eighteen', 19=> 'nineteen', 20=> 'twenty', 30=> 'thirty', 40=> 'forty', 50=> 'fifty', 60=> 'sixty', 70=> 'seventy', 80=> 'eighty', 90=> 'ninety', 100=> "hundred" }

num_string = " "

# define some methords:

def suffix(num)
  case num
    when 5
      "trillion, "
    when 4
      "billion, "
    when 3
      "million, "
    when 2
      "thousand, "
    when 1
      ""
  end
end

def parse_block(num)
  words = ""
  if num.to_s.length < 3
    parse_two_digits(num)
  else
    hundreds = num.to_s[0].to_i
    two_digits = num.to_s[1..2].to_i

    words = @number_words[hundreds] + " hundred " + parse_two_digits( num.to_s[1..2].to_i ) + " "
  end
end

def parse_two_digits(num)
  words = ""

  if num < 21
    words << @number_words[num] + ' '
  else
    tens = num.to_s[-2].to_i * 10
    ones = num.to_s[-1].to_i
    words << ( @number_words[tens] + " " + @number_words[ones] )
  end

  words
end


### start the program:

if digits > 15
  puts 'number is just too big to think about'
else

  ## get the leading block of numbers
  ## then strip them from num variable
  first_block = 0

  if digits % 3 == 0
    first_block = num.to_s[0..2].to_i
    num = num.to_s[3..-1].to_i
  elsif digits % 3 == 1
    first_block = num.to_s[0].to_i
    num = num.to_s[1..-1].to_i
  else
    first_block = num.to_s[0..1].to_i
    num = num.to_s[1..-2].to_i
  end

  num_string << parse_block(first_block) + suffix(blocks)
  blocks -= 1 

  while blocks > 0 do
    block = num.to_s[0..2].to_i
    num = num.to_s[2..-1].to_i

    num_string << parse_block(block) + suffix(blocks)
    blocks -= 1
  end
end

num_string.split.join(' ')
puts "Your number is " << num_string