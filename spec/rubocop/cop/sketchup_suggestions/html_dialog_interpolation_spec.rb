# frozen_string_literal: true

require 'spec_helper'

describe RuboCop::Cop::SketchupSuggestions::HtmlDialogInterpolation, :config do

  it 'registers an offense when building a script for `execute_script`' do
    expect_offense(<<~RUBY)
      dialog.execute_script("updateName('Wall')")
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Avoid building JavaScript with string interpolation in [...]
    RUBY
  end

  it 'registers an offense when calling `execute_script` on an instance variable' do
    expect_offense(<<~RUBY)
      @dialog.execute_script('refresh()')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Avoid building JavaScript with string interpolation in [...]
    RUBY
  end

  it 'does not register an offense when passing a variable' do
    expect_no_offenses(<<~RUBY)
      script = "updateName(\#{name.to_json})"
      dialog.execute_script(script)
    RUBY
  end

  it 'does not register an offense for other methods' do
    expect_no_offenses(<<~RUBY)
      dialog.set_html("<p>Hello</p>")
    RUBY
  end
end
