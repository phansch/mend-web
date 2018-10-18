# frozen_string_literal: true

require 'test_helper'
require 'ci/build'

module CI
  class BuildTest < Minitest::Test
    def setup
      @build = Build.new
    end

    def test_run_task
      assert_output(
        /Running lint:dummy/
      ) { @build.run_task('lint:dummy') }
    end

    def test_heading
      assert_equal(
        @build.heading('abc'),
        "\n\e[1;33m[Travis CI] abc\e[m\n"
      )
    end

    def test_failures
      fake_results = {
        'task_a' => true,
        'task_b' => false
      }
      @build.instance_variable_set(:@results, fake_results)
      assert_equal(
        @build.failures,
        'task_b' => false
      )
    end

    def test_handle_results_with_failures
      fake_results = {
        'task_a' => true,
        'task_b' => false
      }
      @build.instance_variable_set(:@results, fake_results)
      assert_output(
        /Build FAILED because of task_b/
      ) { @build.handle_results }
    end

    def test_handle_results_with_no_failures
      fake_results = {
        'task_a' => true,
        'task_b' => true
      }
      @build.instance_variable_set(:@results, fake_results)
      assert_output(
        /Build finished successfully/
      ) { @build.handle_results }
    end
  end
end
