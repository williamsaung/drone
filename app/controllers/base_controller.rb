class BaseController < ApplicationController
  def open_door

    # child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "ruby ~/drone/drone-comms/base/base_open_ssh.rb open_motor.py")
    # child_pid = spawn("ruby ~/drone-comms/base/base_open_ssh.rb open_motor.py")
    # child_pid = spawn("ruby ~/drone/drone-comms/base/base_open_ssh.rb open_motor.py")
    # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "ruby ~/drone/drone-comms/base/base_open_ssh.rb open_motor.py")

    child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/base/open_door.py")
    Process.detach(child_pid)

    redirect_to forecasts_show_path
  end

  def close_door

    # child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "ruby ~/drone/drone-comms/base/base_open_ssh.rb open_motor.py")
    # child_pid = spawn("ruby ~/drone-comms/base/base_open_ssh.rb open_motor.py")
    # child_pid = spawn("ruby ~/drone/drone-comms/base/base_open_ssh.rb open_motor.py")
    # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "ruby ~/drone/drone-comms/base/base_open_ssh.rb open_motor.py")

    child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/base/close_door.py")
    Process.detach(child_pid)

    redirect_to forecasts_show_path
  end
end
