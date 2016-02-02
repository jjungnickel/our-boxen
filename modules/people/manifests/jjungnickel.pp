class people::jjungnickel {
  ### OSX Settings
  include osx::global::enable_standard_function_keys
  include osx::global::disable_autocorrect
  include osx::global::tap_to_click

  # Dock
  include osx::dock::hide_indicator_lights
  include osx::dock::clear_dock
  include osx::dock::autohide
  class { 'osx::dock::icon_size':
    size => 24
  }
  class { 'osx::dock::position':
    position => 'right'
  }
  class { 'osx::dock::pin_position':
    position => 'start'
  }

  # Finder
  include osx::finder::unhide_library
  include osx::finder::show_all_filename_extensions

  # Keyboard
  # TODO Maybe disable 'force-correct-shifts' -- How?
  include modern_space_cadet
  include osx::keyboard::capslock_to_control
  class { 'osx::global::key_repeat_delay':
    delay => 35
  }
  class { 'osx::global::key_repeat_rate':
    rate => 5
  }

  # Misc
  include osx::safari::enable_developer_mode
  include osx::software_update
  ### End OSX Settings

  ### Shell/Terminal/Basics
  include zsh
  include dotfiles
  include fonts::adobe::sourcecodepro
  include iterm2::stable
  include iterm2::colors::tomorrow_night_eighties

  homebrew::tap { 'railwaycat/homebrew-emacsmacport': }
  package { 'emacs-mac':
    ensure => present,
    install_options => [ '--with-spacemacs-icon' ]
  }
  package { 'mackup': provider => homebrew }

  ### Desktop Apps
  package { '1password': provider => brewcask }
  package { 'dropbox': provider => brewcask }
  package { 'bartender': provider => brewcask }
  package { 'spectacle': provider => brewcask }
}
