## Monkeypatch knife to add in callback support


class Chef::Application::Knife
  # Run knife
  def run
    require 'knife-santoku'
    require 'pry'
    santoku = ::KnifeSantoku::Application.new(ARGV)

    Mixlib::Log::Formatter.show_time = false
    validate_and_parse_options
    quiet_traps

    santoku.run_before_callbacks
    Chef::Knife.run(ARGV, options)

    santoku.run_after_callbacks

    exit 0
  end

end
