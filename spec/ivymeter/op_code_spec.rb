# frozen_string_literal: true

RSpec.describe IvyMeter::OpCode do
  let(:attributes) do
    {
      code: '1234',
      machine_type: 'AFCS',
      equipment_description: 'Advanced Facer Canceller System',
      stop_the_clock_scan: true,
      clearance_cutoff_time: '18:00',
      handling_event_type: 'Actual',
      piece_mail_type: 'Letters',
      mail_level: 'O/G Secondary',
      mail_phase: 'Processing',
      process_description: 'Mail Processing',
      available_date: '2024-01-01',
      last_updated: '2024-01-01'
    }
  end

  let(:opcode) { described_class.new(attributes) }

  describe 'initialization' do
    it 'sets all attributes correctly' do
      expect(opcode.code).to eq('1234')
      expect(opcode.machine_type).to eq('AFCS')
      expect(opcode.equipment_description).to eq('Advanced Facer Canceller System')
      expect(opcode.stop_the_clock_scan).to be true
      expect(opcode.clearance_cutoff_time).to eq('18:00')
      expect(opcode.handling_event_type).to eq('Actual')
      expect(opcode.piece_mail_type).to eq('Letters')
      expect(opcode.mail_level).to eq('O/G Secondary')
      expect(opcode.mail_phase).to eq('Processing')
      expect(opcode.process_description).to eq('Mail Processing')
      expect(opcode.available_date).to eq('2024-01-01')
      expect(opcode.last_updated).to eq('2024-01-01')
    end

    it 'handles missing optional attributes' do
      minimal_opcode = described_class.new(code: '1234')
      expect(minimal_opcode.code).to eq('1234')
      expect(minimal_opcode.machine_type).to be_nil
      expect(minimal_opcode.equipment_description).to be_nil
      expect(minimal_opcode.stop_the_clock_scan).to be_nil
      expect(minimal_opcode.clearance_cutoff_time).to be_nil
      expect(minimal_opcode.handling_event_type).to be_nil
      expect(minimal_opcode.piece_mail_type).to be_nil
      expect(minimal_opcode.mail_level).to be_nil
      expect(minimal_opcode.mail_phase).to be_nil
      expect(minimal_opcode.process_description).to be_nil
      expect(minimal_opcode.available_date).to be_nil
      expect(minimal_opcode.last_updated).to be_nil
    end
  end

  describe '.find' do
    it 'finds an opcode by code' do
      expect(described_class.find('000')).to be_a(described_class)
      expect(described_class.find('000').code).to eq('000')
    end

    it 'returns nil for unknown opcodes' do
      expect(described_class.find('9999')).to be_nil
    end

    it 'converts code to string' do
      expect(described_class.find(113)).to be_a(described_class)
      expect(described_class.find(113).code).to eq('113')
    end

    it 'handles unexpected codes' do
      unexpected = described_class.find('029')
      expect(unexpected).to be_a(described_class)
      expect(unexpected.code).to eq('029')
      expect(unexpected.unexpected?).to be true
    end
  end

  describe '#stop_the_clock_scan?' do
    it 'returns true for stop the clock scans' do
      expect(opcode.stop_the_clock_scan?).to be true
    end

    it 'returns false for non-stop the clock scans' do
      non_stop_opcode = described_class.new(attributes.merge(stop_the_clock_scan: false))
      expect(non_stop_opcode.stop_the_clock_scan?).to be false
    end

    it 'returns false when stop_the_clock_scan is nil' do
      nil_stop_opcode = described_class.new(attributes.merge(stop_the_clock_scan: nil))
      expect(nil_stop_opcode.stop_the_clock_scan?).to be false
    end
  end

  describe '#unexpected?' do
    it 'returns true for codes in UNEXPECTED_CODES' do
      unexpected = described_class.find('029')
      expect(unexpected.unexpected?).to be true
    end

    it 'returns false for codes not in UNEXPECTED_CODES' do
      expected = described_class.find('000')
      expect(expected.unexpected?).to be false
    end
  end

  describe 'equality' do
    it 'returns the same object for the same code' do
      opcode1 = described_class.find('000')
      opcode2 = described_class.find('000')
      expect(opcode1).to eq(opcode2)
    end

    it 'returns different objects for different codes' do
      opcode1 = described_class.find('000')
      opcode2 = described_class.find('113')
      expect(opcode1).not_to eq(opcode2)
    end
  end
end
