RSpec.describe Mongoid::Falsehoods do
  context 'not breaking DateTime' do
    let(:date_time) { DateTime.new(2020, 2, 21, 10, 0, 0) }

    it 'mongoizes' do
      expect(DateTime.mongoize(date_time)).to eq date_time
    end

    it 'demongoizes' do
      expect(DateTime.demongoize(date_time)).to eq date_time
    end
  end

  context 'keeping false as false instead of nil' do
    it 'mongoizes' do
      expect(DateTime.mongoize(false)).to eq false
    end

    it 'demongoizes' do
      expect(DateTime.demongoize(false)).to eq false
    end
  end
end
