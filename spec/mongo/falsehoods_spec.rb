RSpec.describe Mongo::Falsehoods do
  it "has a version number" do
    expect(Mongo::Falsehoods::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
