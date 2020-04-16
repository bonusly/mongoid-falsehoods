RSpec.describe Mongoid::Falsehoods do
  context 'DateTime' do
    context 'does not break DateTime itself' do
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

  context 'Time' do
    context 'does not break Time itself' do
      let(:date_time) { Time.new(2020, 2, 21, 10, 0, 0) }

      it 'mongoizes' do
        expect(Time.mongoize(date_time)).to eq date_time
      end

      it 'demongoizes' do
        expect(Time.demongoize(date_time)).to eq date_time
      end
    end

    context 'keeping false as false instead of nil' do
      it 'mongoizes' do
        expect(Time.mongoize(false)).to eq false
      end

      it 'demongoizes' do
        expect(Time.demongoize(false)).to eq false
      end
    end
  end
end
