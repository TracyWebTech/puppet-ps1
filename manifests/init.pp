class ps1 (
  $color = 'red'
) {
  $color_code = $color ? {
    'red' => '1',
    'green' => '2',
    'yellow' => '3',
    default => '1'
  }

  file { '/etc/bash_completion.d/ps1':
    content => "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;3${color_code}m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '",
  }

  if $::operatingsystem == 'ubuntu' {
    $root_path = '/root/.bashrc'

    # uncomment  force_color_prompt in root
    $force_color_prompt_cmd = "/bin/sed -i -re '/force_color_prompt=yes/ s/^#//'"
    $force_color_prompt_condition = '/bin/grep "#force_color_prompt"'

    exec { "$force_color_prompt_cmd $root_path":
      onlyif => "$force_color_prompt_condition $root_path"
    }

    # change prompt color in root
    $ps1_color_cmd = "/bin/sed -i -re 's/01;3[1-3]m/01;3${color_code}m/'"
    $ps1_color_condition = "/bin/grep '01;3${color_code}m'"

    exec { "$ps1_color_cmd $root_path":
      unless => "$ps1_color_condition $root_path",
    }
  }
}
