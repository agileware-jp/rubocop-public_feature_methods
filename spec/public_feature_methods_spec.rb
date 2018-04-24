# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Lint::PublicFeatureMethods do
  subject(:cop) { described_class.new }

  describe 'include' do
    it {
      msg = 'Use `IssuesController.include(Lychee::IssuesControllerPatch)` instead of `IssuesController.send(:include, Lychee::IssuesControllerPatch)`'
      expect_offense(<<~RUBY)
        IssuesController.send(:include, Lychee::IssuesControllerPatch)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      RUBY
    }

    it {
      new_source = autocorrect_source(<<~RUBY)
        IssuesController.send(:include, Lychee::IssuesControllerPatch)
      RUBY
      expect(new_source).to eq(<<~RUBY)
        IssuesController.include(Lychee::IssuesControllerPatch)
      RUBY
    }

    it {
      expect_no_offenses(<<~RUBY)
        IssuesController.include(Lychee::IssuesControllerPatch)
      RUBY
    }
  end

  describe 'prepend' do
    it {
      msg = 'Use `IssuesController.prepend(Lychee::IssuesControllerPatch)` instead of `IssuesController.send(:prepend, Lychee::IssuesControllerPatch)`'
      expect_offense(<<~RUBY)
        IssuesController.send(:prepend, Lychee::IssuesControllerPatch)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{msg}
      RUBY
    }

    it {
      new_source = autocorrect_source(<<~RUBY)
        IssuesController.send(:prepend, Lychee::IssuesControllerPatch)
      RUBY
      expect(new_source).to eq(<<~RUBY)
        IssuesController.prepend(Lychee::IssuesControllerPatch)
      RUBY
    }

    it {
      expect_no_offenses(<<~RUBY)
        IssuesController.prepend(Lychee::IssuesControllerPatch)
      RUBY
    }
  end
end
