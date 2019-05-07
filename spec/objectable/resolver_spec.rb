# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe Objectable::Resolver do
  subject { described_class.new }

  context 'when input is a hash' do
    let(:input) do
      {
        'id' => 1,
        demographics: {
          'first' => 'Matt'
        }
      }
    end

    describe '#get' do
      it 'resolves correct value' do
        expect(subject.get(input, :id)).to  eq(input['id'])
        expect(subject.get(input, 'id')).to eq(input['id'])
      end

      it 'resolves correct value for nested objects' do
        expect(subject.get(input, 'demographics.first')).to eq(input.dig(:demographics, 'first'))
      end
    end

    describe '#set' do
      it 'sets correct value' do
        subject.set(input, :active, true)
        expect(subject.get(input, :active)).to  be true
        expect(subject.get(input, 'active')).to be true

        subject.set(input, 'super_power', :thunder)
        expect(subject.get(input, 'super_power')).to  eq(:thunder)
        expect(subject.get(input, :super_power)).to   eq(:thunder)
      end

      it 'sets correct value for nested objects' do
        subject.set(input, :'statuses.active', true)
        expect(subject.get(input, 'statuses.active')).to  be true
        expect(subject.get(input, :'statuses.active')).to be true

        subject.set(input, 'powers.super_power', :thunder)
        expect(subject.get(input, 'powers.super_power')).to   eq(:thunder)
        expect(subject.get(input, :'powers.super_power')).to  eq(:thunder)

        expect(subject.get(input, 'powers')).to eq('super_power' => :thunder)
      end
    end
  end

  context 'when input is an OpenStruct' do
    let(:input) do
      OpenStruct.new(
        id: 1,
        demographics: OpenStruct.new(
          first: 'Matt'
        )
      )
    end

    describe '#get' do
      it 'resolves correct value' do
        expect(subject.get(input, :id)).to  eq(input.id)
        expect(subject.get(input, 'id')).to eq(input.id)
      end

      it 'resolves correct value for nested objects' do
        expect(subject.get(input, 'demographics.first')).to eq(input.demographics.first)
      end
    end

    describe '#set' do
      it 'sets correct value' do
        subject.set(input, :active, true)
        expect(subject.get(input, :active)).to  be true
        expect(subject.get(input, 'active')).to be true

        subject.set(input, 'super_power', :thunder)
        expect(subject.get(input, 'super_power')).to  eq(:thunder)
        expect(subject.get(input, :super_power)).to   eq(:thunder)
      end

      it 'sets overrides existing value' do
        subject.set(input, :id, 999)
        expect(subject.get(input, :id)).to  eq(999)
        expect(subject.get(input, 'id')).to eq(999)

        subject.set(input, 'id', 123)
        expect(subject.get(input, :id)).to  eq(123)
        expect(subject.get(input, 'id')).to eq(123)
      end

      it 'set correct value for nested objects' do
        subject.set(input, :'statuses.active', true)
        expect(subject.get(input, 'statuses.active')).to  be true
        expect(subject.get(input, :'statuses.active')).to be true

        subject.set(input, 'powers.super_power', :thunder)
        expect(subject.get(input, 'powers.super_power')).to   eq(:thunder)
        expect(subject.get(input, :'powers.super_power')).to  eq(:thunder)

        expect(subject.get(input, 'powers')).to eq(OpenStruct.new('super_power' => :thunder))
      end
    end
  end
end
