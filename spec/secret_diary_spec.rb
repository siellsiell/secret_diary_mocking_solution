require_relative '../lib/secret_diary'

### WARNING ###
# For the purposes of this exercise, you are testing after
# the code has been written. This means your tests are prone
# to false positives!
#
# Make sure your tests work by deleting the bodies of the
# methods in `secret_diary.rb`, like this:
#
# ```ruby
# def write(new_message)
# end
# ```
#
# If they fail, then you know your tests are working
# as expected.
### WARNING ###

RSpec.describe SecretDiary do
  context "when locked" do
    it "refuses to be read" do
      # Arrange
      foo = double(:my_notebook)
      secret_diary = SecretDiary.new(foo)
      secret_diary.lock

      # Assert
      expect(foo).not_to receive(:read)

      # Act + Assert
      expect(secret_diary.read).to eq("Go away!")
    end

    it "refuses to be written" do
      # Arrange
      foo = double(:my_notebook)
      secret_diary = SecretDiary.new(foo)
      secret_diary.lock

      # Assert
      expect(foo).not_to receive(:write)

      # Act + Assert
      expect(secret_diary.write("I don't like animals")).to eq("Go away!")
    end

  end

  context "when unlocked" do
    it "gets read" do
      # Arrange
      notebook_double = double(:my_notebook, :read => "my secret") # This is a shorthand for stubbing methods§
      secret_diary = SecretDiary.new(notebook_double)
      secret_diary.unlock

      # This is another way to stub a method on a double
      # allow(notebook_double).to receive(:read).and_return("my secret")

      # Act + Assert
      expect(secret_diary.read).to eq("my secret")
    end

    it "gets read with spies" do
      # Arrange
      foo = spy(:my_notebook)
      secret_diary = SecretDiary.new(foo)

      secret_diary.unlock

      # Act
      secret_diary.read

      # Assert
      expect(foo).to have_received(:read)
    end

    pending "gets written"
  end
end
