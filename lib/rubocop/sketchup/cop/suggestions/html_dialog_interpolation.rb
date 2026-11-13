# frozen_string_literal: true

module RuboCop
  module Cop
    module SketchupSuggestions
      # Avoid building JavaScript with string interpolation when calling
      # `UI::HtmlDialog#execute_script`.
      #
      # Interpolating Ruby values directly into a JavaScript string allows
      # values such as entity names, attribute values or file paths to break
      # out of the intended script and execute arbitrary JavaScript in the
      # dialog. Serialize data to JSON instead and pass it to a function
      # defined in the dialog.
      #
      # Use `AllowedReceivers` to skip dialogs known to only receive trusted
      # input.
      #
      # @example
      #   # bad
      #   dialog.execute_script("updateName('#{entity.name}')")
      #
      #   # good
      #   script = "updateName(#{entity.name.to_json})"
      #   dialog.execute_script(script)
      class HtmlDialogInterpolation < SketchUp::Cop
        MSG = 'Avoid building JavaScript with string interpolation in ' \
              '`execute_script`. Pass data as JSON to prevent script ' \
              'injection.'

        # Matches `execute_script` called with an interpolated string literal.
        def_node_matcher :execute_script_with_string, <<-PATTERN
          (send $_ :execute_script $str)
        PATTERN

        def on_send(node)
          execute_script_with_string(node) do |receiver, _script|
            next if skip_receiver?(receiver)

            add_offense(node, message: MSG)
          end
        end

        private

        def skip_receiver?(receiver)
          return false if allowed_receivers.empty?

          !allowed_receivers.include?(receiver_name(receiver))
        end

        def receiver_name(receiver)
          receiver.nil? ? 'self' : receiver.source
        end

        def allowed_receivers
          cop_config['AllowedReceivers'] || []
        end
      end
    end
  end
end
