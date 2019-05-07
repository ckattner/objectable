# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'objectable/resolver'

# Top-level API
module Objectable
  class << self
    # Really just syntactic sugar that proxies a new Resolver instance creation.
    def resolver(*args)
      Resolver.new(*args)
    end
  end
end
