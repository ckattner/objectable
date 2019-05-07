# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'interface'

module Objectable
  # The main logic value proposition of this library.  An instance of this class can act as
  # a value-get and value-set arbiter for objects.
  class Resolver
    DEFAULT_SEPARATOR = '.'

    attr_reader :separator

    def initialize(separator: DEFAULT_SEPARATOR)
      @interface = Interface.new
      @separator = separator.to_s

      freeze
    end

    def get(object, expression, traverse: true)
      if traverse
        traverse(object, key_path(expression))
      else
        interface.get(object, expression)
      end
    end

    def set(object, expression, value, traverse: true)
      if traverse
        build_up(object, key_path(expression), value)
      else
        interface.set(object, expression, value)
      end
    end

    def ==(other)
      eql?(other)
    end

    def eql?(other)
      return false unless other.is_a?(self.class)

      separator == other.separator
    end

    private

    attr_reader :interface

    def key_path(expression)
      return expression        if expression.is_a?(Array)
      return Array(expression) if separator.empty?

      expression.to_s.split(separator)
    end

    def traverse(object, through)
      pointer = object

      through.each do |key|
        next unless pointer

        pointer = interface.get(pointer, key)
      end

      pointer
    end

    def build_up(object, through, value)
      object.tap do |o|
        pointer = o

        preceding_keys = through[0..-2]
        last_key       = through.last

        preceding_keys.each do |key|
          pointer = interface.get(pointer, key) || build_and_set(pointer, key)
        end

        interface.set(pointer, last_key, value)
      end

      def build_and_set(pointer, key)
        interface.get(interface.set(pointer, key, pointer.class.new), key)
      end
    end
  end
end
