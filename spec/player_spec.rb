require_relative '../lib/player.rb'

describe Player do
 
  describe '#get_name' do
     subject(:player) {described_class.new(1, '\u26aa')}
     
    it 'changes name to user input' do
      allow(player).to receive(:gets).and_return('Bob')
      player.get_name
      name = player.name
      expect(name).to eql('Bob')
    end
  end
end
