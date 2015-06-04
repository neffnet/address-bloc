RSpec.describe AddressBook do  
  context "attributes" do
    it "should respond to entries" do
      book = AddressBook.new
      expect(book).to respond_to(:entries)
    end

    it "should initialize entries as an array" do
      book = AddressBook.new
      expect(book.entries).to be_a(Array)
    end

    it "should initialize entries as empty" do
      book = AddressBook.new
      expect(book.entries.size).eql? 0
    end
  end

  context ".add_entry" do
    it "adds only one entry to the address book" do
      book = AddressBook.new
      book.add_entry("Some Name", "425.634.5774", "anemail@email.com")

      expect(book.entries.size).eql? 1
    end

    it "adds the correct information to entries" do
      book = AddressBook.new
      book.add_entry("Ada Lovelace", "100.101.1001", "email@email.com")
      new_entry = book.entries[0]

      expect(new_entry.name).eql? "Ada Lovelace"
      expect(new_entry.phone_number).eql? "100.101.1001"
      expect(new_entry.email).eql? "email@email.com"
    end
  end
end