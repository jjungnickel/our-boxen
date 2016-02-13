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
  package { 'mackup': provider => homebrew }
  # Fonts
  homebrew::tap { 'caskroom/fonts': } ~> package { 'font-fira-code': provider => brewcask }
  # This is a quick workaround to disable bold/light/medium faces globally, since there's no easy
  # way to convince some apps to *not* use bold faces
  exec { 'kill-non-regular-faces':
    command => "osascript -e '
    set disable_typefaces to {\"Light\", \"Bold\", \"Medium\"}
    tell application \"Font Book\"
	  set faces to typefaces whose family name is \"Fira Code\"
	  repeat with f in faces
	  if family name of f is \"Fira Code\" and disable_typefaces contains style name of f then set enabled of f to false
	  end repeat
    end tell
    '"}

  # Terminal
  include iterm2::stable
  include iterm2::colors::tomorrow_night_eighties

  # Emacs
  homebrew::tap { 'railwaycat/homebrew-emacsmacport': }
  package { 'emacs-mac':
    ensure => present,
    install_options => [ '--with-spacemacs-icon' ]
  }

  ### Desktop Apps
  package { [
    '1password',
    'dropbox',
    'bartender',
    'spectacle',
    'istat-menus',
    'spotify',
    'viscosity',
    'vlc',
    'telegram'
  ]: provider => brewcask }

  ### Development
  # Docker
  package { 'virtualbox': provider => brewcask }
  include docker

  # Java
  package { 'java': provider => brewcask }
  package { 'intellij-idea': provider => brewcask }

  ### Mail
  package { 'quotefix': provider => brewcask }

  ### FUSE
  package { 'osxfuse': provider => brewcask }
  ~> homebrew::tap { 'homebrew/fuse': }
  ~> package { 'ext4fuse': }

  ### "Stuff"
  package { 'steam':
    provider => brewcask,
    ensure => hiera("machine::type") ? {
      "home" => present,
      default => absent
    }
  }
}
