require_relative "../models/address_book"

class MenuController
  attr_accessor :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    puts "Main Menu - #{@address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create a new entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Delete ALL entries"
    puts "6 - Exit"
    puts ""
    print "Enter your selection: "

    selection = gets.to_i
    
    case selection
    when 1
      system "clear"
      view_all_entries
      main_menu
    when 2
      system "clear"
      create_entry
      main_menu
    when 3
      system "clear"
      search_entries
      main_menu
    when 4
      system "clear"
      read_csv
      main_menu
    when 5
      system "clear"
      nuke_all
      main_menu
    when 6
      puts "goodbye"
      exit(0)
    else
      system "clear"
      puts "Please enter a valid input"
      main_menu
    end
  end

  def view_all_entries
    @address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s

      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

  def create_entry
    system "clear"
    puts "New AddressBloc Entry"

    print "Name: "
    name = gets.chomp

    print "Phone number: "
    phone = gets.chomp

    print "Email: "
    email = gets.chomp

    @address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"
  end

  def edit_entry(entry)
    print "Enter updated name (or leave blank to remain unchanged): "
    name = gets.chomp
    print "Enter updated phone number: "
    phone_number = gets.chomp
    print "Enter updated email: "
    email = gets.chomp

    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?

    puts ""
    puts "Updated entry: "
    puts entry.to_s
  end

  def delete_entry(entry)
    @address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def search_entries
    print "Search by name: "
    name = gets.chomp

    match = @address_book.binary_search(name)
    system "clear"
    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end

  def read_csv
    print "File path of CSV to import: "
    file_name = gets.chomp

    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    begin
      entry_count = @address_book.import_from_csv(file_name)
      system "clear"
      puts "#{entry_count} new entries imported from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file. Please enter the name of a valid CSV file"
      read_csv
    end
  end

  def search_submenu(entry)
    puts "\nd - delete entry"
    puts "e - edit entry"
    puts "m - back to main menu"
    selection = gets.chomp

    case selection
    when "d"
      system "clear"
      delete_entry(entry)
      main_menu

    when "e"
      edit_entry(entry)
      system "clear"
      main_menu

    when "m"
      system "clear"
      main_menu

    else
      system "clear"
      puts "#{selection} is not a valid input"
      puts entry.to_s
      search_submenu(entry)
    end
  end

  def entry_submenu(entry)
    puts ""
    puts "n - next entry"
    puts "d - delete this entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    selection = gets.chomp

    case selection
    when "n"

    when "d"
      delete_entry(entry)

    when "e"
      edit_entry(entry)
      entry_submenu(entry)

    when "m"
      system "clear"
      main_menu

    else
      system "clear"
      puts "#{selection} is not a valid input"
    end
  end

  def nuke_all
    puts "This will DELETE ALL THE ENTRIES! Enter y to confirm or n to go back: "
    
    if gets.chomp == "y" || "yes" || "Y"
      system "clear"
      @address_book.entries.each do |entry|
        delete_entry(entry)
      end

      puts "\nAll entries have been deleted."
      main_menu
    end

  end
end