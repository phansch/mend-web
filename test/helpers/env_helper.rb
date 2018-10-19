# frozen_string_literal: true

class EnvHelper
  # Sets an environment variable inside the given block
  def self.with_env(name, val)
    old_val = ENV[name]
    ENV[name] = val
    result = yield
    ENV[name] = old_val
    result
  end
end
