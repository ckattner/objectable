# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require './spec/spec_helper'

describe Objectable do
  describe '#resolver' do
    specify 'with no arguments' do
      resolver = described_class.resolver

      expect(resolver).to be_a(Objectable::Resolver)
      expect(resolver.separator).to eq('.')
    end

    specify 'with arguments' do
      resolver1 = described_class.resolver(separator: '$')
      resolver2 = described_class.resolver(separator: '$')

      expect(resolver1).to eq(resolver2)
      expect(resolver1.separator).to eq('$')
      expect(resolver2.separator).to eq('$')
    end
  end

  describe 'README examples' do
    Employee      = Struct.new(:id, :demographics)
    Demographics  = Struct.new(:first)

    let(:symbol_based_hash) do
      { id: 1, demographics: { first: 'Matt' } }
    end

    let(:string_based_hash) do
      { 'id' => 1, 'demographics' => { 'first' => 'Matt' } }
    end

    let(:open_struct) do
      OpenStruct.new(id: 1, demographics: OpenStruct.new(first: 'Matt'))
    end

    let(:object) do
      Employee.new(1, Demographics.new('Matt'))
    end

    specify 'getting examples' do
      resolver = Objectable.resolver

      expect(resolver.get(symbol_based_hash, :id)).to eq(1)
      expect(resolver.get(symbol_based_hash, 'id')).to eq(1)
      expect(resolver.get(string_based_hash, :id)).to eq(1)
      expect(resolver.get(string_based_hash, 'id')).to eq(1)
      expect(resolver.get(open_struct, :id)).to eq(1)
      expect(resolver.get(open_struct, 'id')).to eq(1)
      expect(resolver.get(object, :id)).to eq(1)
      expect(resolver.get(object, 'id')).to eq(1)

      expect(resolver.get(symbol_based_hash, :'demographics.first')).to eq('Matt')
      expect(resolver.get(symbol_based_hash, 'demographics.first')).to eq('Matt')
      expect(resolver.get(string_based_hash, :'demographics.first')).to eq('Matt')
      expect(resolver.get(string_based_hash, 'demographics.first')).to eq('Matt')
      expect(resolver.get(open_struct, :'demographics.first')).to eq('Matt')
      expect(resolver.get(open_struct, 'demographics.first')).to eq('Matt')
      expect(resolver.get(object, :'demographics.first')).to eq('Matt')
      expect(resolver.get(object, 'demographics.first')).to eq('Matt')
    end

    specify 'setting examples using symbols' do
      resolver = Objectable.resolver

      resolver.set(symbol_based_hash, :id, 999)
      resolver.set(string_based_hash, :id, 999)
      resolver.set(open_struct, :id, 999)
      resolver.set(object, :id, 999)

      expect(resolver.get(symbol_based_hash, :id)).to eq(999)
      expect(resolver.get(symbol_based_hash, 'id')).to eq(999)
      expect(resolver.get(string_based_hash, :id)).to eq(999)
      expect(resolver.get(string_based_hash, 'id')).to eq(999)
      expect(resolver.get(open_struct, :id)).to eq(999)
      expect(resolver.get(open_struct, 'id')).to eq(999)
      expect(resolver.get(object, :id)).to eq(999)
      expect(resolver.get(object, 'id')).to eq(999)

      resolver.set(symbol_based_hash, :'demographics.first', 'Nick')
      resolver.set(string_based_hash, :'demographics.first', 'Nick')
      resolver.set(open_struct, :'demographics.first', 'Nick')
      resolver.set(object, :'demographics.first', 'Nick')

      expect(resolver.get(symbol_based_hash, :'demographics.first')).to eq('Nick')
      expect(resolver.get(symbol_based_hash, 'demographics.first')).to eq('Nick')
      expect(resolver.get(string_based_hash, :'demographics.first')).to eq('Nick')
      expect(resolver.get(string_based_hash, 'demographics.first')).to eq('Nick')
      expect(resolver.get(open_struct, :'demographics.first')).to eq('Nick')
      expect(resolver.get(open_struct, 'demographics.first')).to eq('Nick')
      expect(resolver.get(object, :'demographics.first')).to eq('Nick')
      expect(resolver.get(object, 'demographics.first')).to eq('Nick')
    end

    specify 'setting examples using strings' do
      resolver = Objectable.resolver

      resolver.set(symbol_based_hash, 'id', 999)
      resolver.set(string_based_hash, 'id', 999)
      resolver.set(open_struct, 'id', 999)
      resolver.set(object, 'id', 999)

      expect(resolver.get(symbol_based_hash, :id)).to eq(999)
      expect(resolver.get(symbol_based_hash, 'id')).to eq(999)
      expect(resolver.get(string_based_hash, :id)).to eq(999)
      expect(resolver.get(string_based_hash, 'id')).to eq(999)
      expect(resolver.get(open_struct, :id)).to eq(999)
      expect(resolver.get(open_struct, 'id')).to eq(999)
      expect(resolver.get(object, :id)).to eq(999)
      expect(resolver.get(object, 'id')).to eq(999)

      resolver.set(symbol_based_hash, 'demographics.first', 'Nick')
      resolver.set(string_based_hash, 'demographics.first', 'Nick')
      resolver.set(open_struct, 'demographics.first', 'Nick')
      resolver.set(object, 'demographics.first', 'Nick')

      expect(resolver.get(symbol_based_hash, :'demographics.first')).to eq('Nick')
      expect(resolver.get(symbol_based_hash, 'demographics.first')).to eq('Nick')
      expect(resolver.get(string_based_hash, :'demographics.first')).to eq('Nick')
      expect(resolver.get(string_based_hash, 'demographics.first')).to eq('Nick')
      expect(resolver.get(open_struct, :'demographics.first')).to eq('Nick')
      expect(resolver.get(open_struct, 'demographics.first')).to eq('Nick')
      expect(resolver.get(object, :'demographics.first')).to eq('Nick')
      expect(resolver.get(object, 'demographics.first')).to eq('Nick')
    end
  end
end
