RSpec.describe Entry do

  context "attributes" do
    it "should respond to name" do
      entry = Entry.new('Ada Lovelace', '101.020.1548', 'this.is@email.com')

      expect(entry).to respond_to(:name)
    end

    it "should respond to phone number" do 
      entry = Entry.new("Somebody Else", "482.425.4242", "another@email.com")

      expect(entry).to respond_to(:phone_number)
    end

    it "should respond to email" do
      entry = Entry.new("Another Name", "482.42.6532", "email@example.com")

      expect(entry).to respond_to(:email)
    end
  end

  context ".to_s" do
    it "prints an entry as a string" do
      entry = Entry.new('Ada Lovelace', '424.3463.2432', 'email@email.em')
      expected_string = "Name: Ada Lovelace\nPhone Number: 424.3463.2432\nEmail: email@email.em"
      
      expect(entry.to_s).to eq(expected_string)
    end
  end

end