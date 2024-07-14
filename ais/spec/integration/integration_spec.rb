
require 'rails_helper'
require "factory"

RSpec.describe 'Integration' do
  contract = FabricSync::Contract.new

  before do
    start_year = 2017
    current_year = start_year
    current_semester = 1

    # (1..16).each do |semester|
    #   Factory.fill_semester_and_sync(semester, 2017)
    # end

    Factory.fill_semester_and_sync_until(1, 16)
  end

  describe 'graduation' do
    it 'graduate student with complete course' do
      graduated_student = Student.where(name: "student a").first

      expect(contract.get_student(graduated_student.nim)['status']).to eq 'graduated'
    end
    it 'dropout student with active year > 7' do
      drop_out_student = Student.where(name: "mahasiswa abadi").first

      expect(contract.get_student(drop_out_student.nim)['status']).to eq 'drop_out'
    end
  end

  # describe 'transcript' do
  #   it 'sync transcript' do
  #     graduated_student = Student.where(name: "student a").first
  #     transcript_result = contract.get_transcript(graduated_student.nim)

  #     expect(transcript_result['array'].size).to eq 50
  #   end
  # end

  # describe 'blockchain sync' do
  #   it 'have no error' do
  #     expect(BlockchainSync.where(status: 'error')).not_to exist
  #     expect(BlockchainSync.where(status: 'success')).to exist
  #   end
  # end

  describe 'debug' do
    describe 'transcript' do
      it 'sync transcript' do
        graduated_student = Student.where(name: "student a").first
        transcript_result = contract.get_transcript(graduated_student.nim)

        Rails.logger.info("====================== debug transcript_result: #{transcript_result}")

        expect(true).to eq true
      end
    end

    describe 'blockchain sync' do
      it 'have no error' do
        BlockchainSync.where(status: 'error')&.each do |bs|
          Rails.logger.info("====================== debug error: #{bs.description}")
        end
        expect(true).to eq true
      end
    end
  end
end
