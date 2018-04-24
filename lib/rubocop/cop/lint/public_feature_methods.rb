# frozen_string_literal: true

require 'rubocop'

module RuboCop
  module Cop
    module Lint
      class PublicFeatureMethods < Cop
        MSG = 'Use `%<correct>s` instead of `%<incorrect>s`'

        def_node_matcher :redundant_send?, <<-PATTERN
          (send $const :send (sym ${:include :prepend}) $const)
        PATTERN

        def on_send(node)
          redundant_send?(node) do |receiver, method_name, arg|
            add_offense(node, message: message(node, receiver, method_name, arg))
          end
        end

        def autocorrect(node)
          receiver, method_name, arg = redundant_send?(node)

          lambda do |corrector|
            corrector.replace(node.source_range, correction(receiver, method_name, arg))
          end
        end

        private

        def correction(receiver, method_name, arg)
          "#{receiver.source}.#{method_name}(#{arg.source})"
        end

        def message(node, receiver, method_name, arg)
          format(MSG,
                 correct: correction(receiver, method_name, arg),
                 incorrect: node.source)
        end
      end
    end
  end
end
