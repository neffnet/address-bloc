# number to words, accepts one number argument

num = ARGV.first
digits = num.to_s.length
blocks = (digits / 3).to_f.ceil

number_words = {0 => '', 1=> 'one', 2=> 'two', 3=> 'three', 4=> 'four', 5=> 'five', 6=> 'six', 7=> 'seven', 8=> 'eight', 9=> 'nine', 10=> 'ten', 11=> 'eleven', 12=> 'twelve', 13=> 'thirteen', 14=> 'fourteen', 15=> 'fifteen', 16=> 'sixteen', 17=> 'seventeen', 18=> 'eighteen', 19=> 'nineteen', 20=> 'twenty', 30=> 'thirty', 40=> 'forty', 50=> 'fifty', 60=> 'sixty', 70=> 'seventy', 80=> 'eighty', 90=> 'ninety'}

def suffix(num)
  case num
    when 5
      "trillion"
    when 4
      "billion"
    when 3
      "million"
    when 2
      "thousand"
    when 1
      ""
  end
end

def parse_block(num)
  hundreds = num.to_s[-3].to_i
  tens = (num.to_s[-2] + '0').to_i
  ones = num.to_s[-1].to_i
  last_two = num.to_s[-2..-1].to_i
  words = ''
  words += (number_words[hundreds] + "hundred" ) if hundreds
  if last_two < 21
    words += number_words(last_two)
  else
    words += number_words(tens) + '' + number_words(ones)
  end
end


if digits > 15
  puts 'number is just too big to think about'
else

  num_string = ''

  if !(digits % 3)
    first_block = num.to_s[0..2].to_i
    num = num.to_s[3..-1].to_i
  elsif digits % 3 == 1
    first_block = num.to_s[0..1].to_i
    num = num.to_s[2..-1].to_i
  else
    first_block = num.to_s[0].to_i
    num = num.to_s[1..-1].to_i
  end

  num_string << parse_block(first_block) + suffix(blocks)
  blocks -= 1 

  while blocks do
    block = num[0..2]
    num = num[2..-1]

    num_string << parse_block(block) + suffix(blocks)
    blocks -= 1
  end
end

puts num_string