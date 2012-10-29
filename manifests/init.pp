class ps1 (
  $color = 'red'
) {
  $color_code = $color ? {
    'red' => '1',
    'green' => '2',
    'yellow' => '3',
    default => '1'
  }

  # uncomment force_color_prompt in skel
  exec {
    "/bin/sed -i -re '/force_color_prompt=yes/ s/^#//' /etc/skel/.bashrc":
  }
  # uncomment  force_color_prompt in root
  exec {
    "/bin/sed -i -re '/force_color_prompt=yes/ s/^#//' /root/.bashrc":
  }

  # change prompt color in skel
  exec {
    "/bin/sed -i -re 's/01;3[1-3]m/01;3${color_code}m/' /etc/skel/.bashrc":
  }
  # change prompt color in root
  exec {
    "/bin/sed -i -re 's/01;3[1-3]m/01;3${color_code}m/' /root/.bashrc":
  }
}