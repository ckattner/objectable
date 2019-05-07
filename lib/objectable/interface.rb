# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Objectable
  # This class defines the direct interface with an object.  Unlike the resolver, this class
  #  cannot handle traversal or nesting, it can only deal with the immediate object interface.
  class Interface
    def get(object, key)
      if object.is_a?(Hash)
        indifferent_hash_get(object, key)
      elsif object.respond_to?(key)
        object.public_send(key)
      end
    end

    def set(object, key, val)
      object.tap do |o|
        setter_method = "#{key}="
        if o.respond_to?(setter_method)
          o.send(setter_method, val)
        elsif o.respond_to?(:[])
          o[key] = val
        end
      end
    end

    private

    def indifferent_hash_get(hash, key)
      if hash.key?(key.to_s)
        hash[key.to_s]
      elsif hash.key?(key.to_s.to_sym)
        hash[key.to_s.to_sym]
      end
    end
  end
end
