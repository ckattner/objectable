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
end
